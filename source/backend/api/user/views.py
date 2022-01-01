from django.db.models import query
from rest_framework import status
from rest_framework.response import Response
from rest_framework.views import APIView
from authentication.utils import IsAuthenticated, IsAdmin
from heybooster.helpers.database.mongodb import MongoDBHelper
from django.conf import settings
from common.models import User
from common.data_check import check_data_keys
from common.wordcloudgen import wordcloudgen
from common.topicname import topicname
from bson.objectid import ObjectId
import base64

class EditUser(APIView):
    """
        Edit User Class
    """

    permission_classes = [IsAuthenticated]

    def post(self, request):
        data = request.data

        with MongoDBHelper(uri=settings.MONGO_URI, database=settings.DB_NAME) as db:
            user = db.find_one('user', query={'email': data['email'], 'username': data['username']})

        if not user:
            return Response({'detail': 'NO_USER'}, status=status.HTTP_400_BAD_REQUEST)
        
        for key, value in data.items():
            user[key] = value

        user = User(**user)
        user.update()

        return Response(user.get_dict(), status=status.HTTP_200_OK)


class SearchUser(APIView):
    """
        Search User Class
    """
    def get(self, request, search_text):
        with MongoDBHelper(uri=settings.MONGO_URI, database=settings.DB_NAME) as db:
            users = db.find(
                'user', # TODO Create fulltext index on username
                query={'$or': [{'$text': {'$search': search_text}}, {'username': {'$regex': search_text, '$options': 'i'}}]},
                projection={'_id': 0, 'username': 1}
            ).limit(10)

        return Response(list(users), status=status.HTTP_200_OK)


class BanUser(APIView):
    permission_classes = [IsAdmin]

    def post(self, request):
        data = request.data
        key_error = check_data_keys(data=data, necessary_keys=['username'])

        if key_error:
            return Response({'detail': key_error}, status.HTTP_400_BAD_REQUEST)

        with MongoDBHelper(uri=settings.MONGO_URI, database=settings.DB_NAME) as db:
            user = db.find_one('user', query={'username': data['username']})

        if not user or user['isBanned']:
            return Response({'detail': 'NO_USER'}, status=status.HTTP_406_NOT_ACCEPTABLE)

        user = User(**user)
        user.isBanned = True
        user.update()

        return Response({'detail': f'User with username: {user.username} banned successfully'},
                        status=status.HTTP_200_OK)

class GetProfile(APIView):

    def get(self, request, username):
        with MongoDBHelper(uri=settings.MONGO_URI, database=settings.DB_NAME) as db:
            user = db.find_one(
                    'user',
                    query={'username': username},
                    projection={
                        '_id': 0,
                        'updatedAt': 0,
                        'password': 0,
                        'lastLogin': 0,
                        'rememberMe': 0, 
                    }
                )

            if not user or user['isBanned'] or user.get('isDeleted'):
                return Response('USER_NOT_FOUND', status=status.HTTP_404_NOT_FOUND)
        
        return Response(user, status=status.HTTP_200_OK)


class ChangePassword(APIView):
    """
            Change User Password after Login
    """
    permission_classes = [IsAuthenticated]

    def post(self, request):
        data = request.data
        key_error = check_data_keys(data=data, necessary_keys=['password'])

        if key_error:
            return Response({'detail': key_error}, status.HTTP_400_BAD_REQUEST)

        with MongoDBHelper(uri=settings.MONGO_URI, database=settings.DB_NAME) as db:
            user = db.find_one('user', query={'email': data['email'], 'username': data['username']})

        if not user:
            return Response({'detail': 'NO_USER'}, status=status.HTTP_400_BAD_REQUEST)

        for key, value in data.items():
            user[key] = value

        user = User(**user)
        user.password = data['password']
        user.hash_password()
        user.update(update_password=True)

        return Response(user.get_dict(), status=status.HTTP_200_OK)



class GetFollow(APIView):
    permission_classes = [IsAuthenticated]
    
    def get(self, request):
        data = request.data


        username = data['username']

        with MongoDBHelper(uri=settings.MONGO_URI, database=settings.DB_NAME) as db:
            followers = list(db.find('follow', query={'followed_username': username}))
            followed = list(db.find('follow', query={'follower_username': username}))


        return Response(
            {
                'followers': [follower['follower_username'] for follower in followers],
                'followed': [followe['followed_username'] for followe in followed]
            },
            status=status.HTTP_200_OK
        )

class GetRatings(APIView):
    permission_classes = [IsAuthenticated]

    def get(self, request):
        data = request.data
        
        username = data['username']

        with MongoDBHelper(uri=settings.MONGO_URI, database=settings.DB_NAME) as db:
            rates = list(db.find('pathRating', query={'username': username}))
            efforts = list(db.find('pathEffort', query={'username': username}))

        return Response(
            {
                'rates': rates,
                'efforts': efforts,
            },
            status=status.HTTP_200_OK
        )


class FollowUser(APIView):
    permission_classes = [IsAuthenticated]

    def post(self, request):
        """
            Endpoint for following a user
        """
        data = request.data

        username = data['username']
        try:
            target = data['target']
        except:
            return Response('MISSING_KEY', status=status.HTTP_400_BAD_REQUEST)

        with MongoDBHelper(uri=settings.MONGO_URI, database=settings.DB_NAME) as db:
            follow = db.find_one('follow', query={'follower_username': username, 'followed_username': target})
            
            if follow:
                return Response('ALREADY_FOLLOWED', status=status.HTTP_409_CONFLICT)

            db.insert_one('follow', {
                'follower_username': username,
                'followed_username': target,
            })

        return Response('SUCCESSFUL')

class UnfollowUser(APIView):
    permission_classes = [IsAuthenticated]

    def post(self, request):
        """
            Endpoint for unfollowing a user
        """
        data = request.data

        username = data['username']
        try:
            target = data['target']
        except:
            return Response('MISSING_KEY', status=status.HTTP_400_BAD_REQUEST)

        with MongoDBHelper(uri=settings.MONGO_URI, database=settings.DB_NAME) as db:
            follow = db.find_one('follow', query={'follower_username': username, 'followed_username': target})
            
            if not follow:
                return Response('NOT_FOLLOWED', status=status.HTTP_409_CONFLICT)

            db.delete_one('follow', { # TODO CHECK
                'follower_username': username,
                'followed_username': target,
            })

        return Response('SUCCESSFUL')


class GetEnrolledPaths(APIView):
    permission_classes = [IsAuthenticated]

    def get(self, request):
        data = request.data
        
        username = data['username']

        with MongoDBHelper(uri=settings.MONGO_URI, database=settings.DB_NAME) as db:
            path_ids = list(db.find('enroll', query={'username': username}, projection={'_id': 1}))
        
        return Response(
            {
                'path_ids': [path_id['_id'] for path_id in path_ids]
            },
            status=status.HTTP_200_OK
        )

class GetFavouritePaths(APIView):
    permission_classes = [IsAuthenticated]

    def get(self, request):
        data = request.data
        
        username = data['username']

        with MongoDBHelper(uri=settings.MONGO_URI, database=settings.DB_NAME) as db:
            path_ids = list(db.find('favourite_path', query={'username': username}, projection={'_id': 1}))

        return Response(
            {
                'path_ids': [path_id['_id'] for path_id in path_ids]
            }
        )


class Wordcloud(APIView):
    permission_classes = [IsAuthenticated]

    def post(self, request):
        data=request.data

        user=data['user']
        try:
            width=data['width']
        except:
            width=600
        try:
            height=data['height']
        except:
            height=400

        paths=set()
        with MongoDBHelper(uri=settings.MONGO_URI, database=settings.DB_NAME) as db:
            res = list(db.find('enroll', query={'username': user}))
            for i in res:
                paths.add(i["path_id"])
        with MongoDBHelper(uri=settings.MONGO_URI, database=settings.DB_NAME) as db:
            res = list(db.find('follow_path', query={'username': user}))
            for i in res:
                paths.add(i["path_id"])
        with MongoDBHelper(uri=settings.MONGO_URI, database=settings.DB_NAME) as db:
            res = list(db.find('pathFinished', query={'username': user}))
            for i in res:
                paths.add(i["path_id"])

        text=""
        topics=list()

        with MongoDBHelper(uri=settings.MONGO_URI, database=settings.DB_NAME) as db:
            res = db.find_one('user', query={'username': user})
            if not res:
                return Response({'detail': 'NO_USER'}, status=status.HTTP_400_BAD_REQUEST)
            text+=(res["bio"]+"\n")*5

        with MongoDBHelper(uri=settings.MONGO_URI, database=settings.DB_NAME) as db:
            res = list(db.find('favorite', query={'username': user}))
            for i in res:
                topics.append(i["ID"])



        for path_id in paths:
            with MongoDBHelper(uri=settings.MONGO_URI, database=settings.DB_NAME) as db:
                path = db.find_one('path', query={'_id': ObjectId(path_id)})
            if not path:
                continue
            text+=path["description"]+"\n"
            text+=path["description"]+"\n" #intentionally added twice to make it more important
            for m in path["milestones"]:
                if type(m)==str:
                    continue
                text+=m["title"]+"\n"
                text+=m["title"]+"\n" # included twice to emphasize
                text+=m["body"]+"\n"

            topics+=path["topics"]


        topicnames=[topicname(t) for t in topics]

        res=wordcloudgen(text,topicnames,width=width,height=height)
        res=base64.b64encode(res)
        #res="data:image/png;base64"+res.decode()
        res = res.decode()
        return Response(res,status=status.HTTP_200_OK)
