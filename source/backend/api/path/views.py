import time
import requests
from rest_framework import permissions, status
from rest_framework.response import Response
from rest_framework.views import APIView
from authentication.utils import IsAuthenticated, IsAdmin
from heybooster.helpers.database.mongodb import MongoDBHelper
from django.conf import settings
from common.models import User
from common.data_check import check_data_keys
from common.wordcloudgen import wordcloudgen
from common.topicname import topicname
from path.utils import get_related_topics
from bson.objectid import ObjectId
import base64
from bson.objectid import ObjectId

class CreatePath(APIView):
    permission_classes = [IsAuthenticated]
    
    def post(self, request):
        data = request.data

        title = data['title']
        description = data['description']
        topics = data['topics']
        creator_username = data['username']
        creator_email = data['email']
        created_at = int(time.time())
        #images = data['images']
        #thumbnail = data['thumbnail']
        photo = data['photo']
        milestones = data['milestones'] # title and body
        # comments = data['comments']
        is_banned = False
        is_deleted = False

        with MongoDBHelper(uri=settings.MONGO_URI, database=settings.DB_NAME) as db:
            topic_ids = []

            for topic in topics:
                if not db.find_one('topic', {'ID': topic['ID']}):
                    db.insert_one('topic', {
                        'ID': topic['ID'],
                        'name': topic['name'],
                        'description': topic['description']
                    })
                
                topic_ids.append(topic['ID'])

            id = db.insert_one('path',
            {
                'title': title,
                'description': description,
                'topics': topic_ids,
                'creator_username': creator_username,
                'creator_email': creator_email,
                'created_at': created_at,
                'photo': photo,
                'milestones': milestones,
                'is_banned': is_banned,
                'is_deleted': is_deleted
            }).inserted_id

        return Response({'pathID': str(id)}, status=status.HTTP_200_OK)

class RatePath(APIView):
    permission_classes = [IsAuthenticated]

    def post(self, request):
        data = request.data

        rating = data['rating']
        path_id = data['path_id']
        username = data['username']

        with MongoDBHelper(uri=settings.MONGO_URI, database=settings.DB_NAME) as db:
            db.insert_one('pathRating',
            {
                'username': username,
                'path_id': path_id,
                'rating': rating,
            })
        
        return Response('SUCCESSFUL')

class EffortPath(APIView): #this endpoint is tested
    permission_classes = [IsAuthenticated]

    def post(self, request):
        data = request.data

        effort = data['effort']
        path_id = data['path_id']
        username = data['username']

        with MongoDBHelper(uri=settings.MONGO_URI, database=settings.DB_NAME) as db:
            db.insert_one('pathEffort',
            {
                'username': username,
                'path_id': path_id,
                'effort': effort,
            })
    
        return Response('SUCCESSFUL')

class GetPathDetail(APIView):
    permission_classes = [IsAuthenticated]

    def post(self, request):
        data = request.data 

        path_id = data['path_id']
        username = data['username']

        rating = 0
        effort = 0

        with MongoDBHelper(uri=settings.MONGO_URI, database=settings.DB_NAME) as db:
            rates = list(db.find('pathRating', query={'path_id': path_id}))
            efforts = list(db.find('pathEffort', query={'path_id': path_id}))

        for rate in rates:
            rating += rate['rating']
        if rates:
            rating /= len(rates)

        for effort_document in efforts:
            effort += effort_document['effort']
        if efforts:
            effort /= len(efforts)

        return Response({
            'rating': rating,
            'effort': effort,
        }, status=status.HTTP_200_OK)

class SearchTopic(APIView):

    def post(self, request):
        data = request.data

        search = data['search']

        with MongoDBHelper(uri=settings.MONGO_URI, database=settings.DB_NAME) as db:
            topics = db.find('')# full text + regex search
        
        return Response(list(topics), status=status.HTTP_200_OK)

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


class FollowUser(APIView):
    permission_classes = [IsAuthenticated]

    def post(self, request):
        data = request.data

        username = data['username']
        target = data['target']

        with MongoDBHelper(uri=settings.MONGO_URI, database=settings.DB_NAME) as db:
            follow = db.find('follow', query={'follower_username': username, 'followed_username': target})
            
            if follow:
                return Response('ALREADY_FOLLOWED', status=status.HTTP_409_CONFLICT)

            db.insert_one('follow', {
                'follower_username': username,
                'followed_username': target,
            })

        return Response('SUCCESSFULL')

class UnfollowUser(APIView):
    permission_classes = [IsAuthenticated]

    def post(self, request):
        data = request.data
        username = data['username']
        target = data['target']

        with MongoDBHelper(uri=settings.MONGO_URI, database=settings.DB_NAME) as db:
            follow = db.find('follow', query={'follower_username': username, 'followed_username': target})
            
            if not follow:
                return Response('NOT_FOLLOWED', status=status.HTTP_409_CONFLICT)

            db.delete_one('follow', { # TODO CHECK
                'follower_username': username,
                'followed_username': target,
            })

        return Response('SUCCESSFUL')

class EnrollPath(APIView):

    permission_classes = [IsAuthenticated]

    """ requests username and path_id and responses success or fail message, tested"""
    def post(self, request):
        data = request.data
        username = data['username']
        target = data['path_id']

        with MongoDBHelper(uri=settings.MONGO_URI, database=settings.DB_NAME) as db:
            relation = db.find_one('enroll', {
                'username': username,
                'path_id': target,
            })

            if relation:
                return Response('ALREADY_ENROLLED', status=status.HTTP_409_CONFLICT)

            db.insert_one('enroll', {
                'username': username,
                'path_id': target,
            })
        
        return Response('SUCCESSFUL')


class UnEnrollPath(APIView):
    permission_classes = [IsAuthenticated]

    """ requests username and path_id and responses success or fail message, tested"""
    def post(self, request):

        data = request.data
        username = data['username']
        target = data['path_id']

        with MongoDBHelper(uri=settings.MONGO_URI, database=settings.DB_NAME) as db:
            relation = db.find_one('enroll', {
                'username': username,
                'path_id': target,
            })

            if not relation:
                return Response('NOT_ENROLLED', status=status.HTTP_409_CONFLICT)

            db.delete_one('enroll', {
                'username': username,
                'path_id': target,
            })
        
        return Response('SUCCESSFUL')

class GetEnrolledPaths(APIView):
    permission_classes = [IsAuthenticated]

    """ requests username and returns all enrolled paths of the given username, tested """
    def get(self, request):
        data = request.data
        username = data['username']

        with MongoDBHelper(uri=settings.MONGO_URI, database=settings.DB_NAME) as db:
            enrolledPaths = list(db.find('enroll', query={'username': username},  projection={'_id': 0}))
            allPaths = list(
                db.find('path', query={'_id': {'$in': [ObjectId(path['path_id']) for path in enrolledPaths]}},
                        projection={'_id': 0}))

        return Response(
            {
                'enrolledPaths': [path for path in zip(enrolledPaths, allPaths)]
            },
            status=status.HTTP_200_OK
        )

class FinishPath(APIView): #Caution: this endpoint marks the whole path as finished, not a single milestone
    permission_classes = [IsAuthenticated]

    def post(self, request):
        data = request.data

        username = data['username']
        path_id = data['path_id']

        with MongoDBHelper(uri=settings.MONGO_URI, database=settings.DB_NAME) as db:
            db.insert_one('pathFinished',
                          {
                              'username': username,
                              'path_id': path_id,
                          })

        return Response('SUCCESSFUL')

class Wordcloud(APIView):
    permission_classes = [IsAuthenticated]

    def post(self, request):
        data=request.data

        path_id=data['path_id']
        try:
            width=data['width']
        except:
            width=600
        try:
            height=data['height']
        except:
            height=400

        with MongoDBHelper(uri=settings.MONGO_URI, database=settings.DB_NAME) as db:
            path = db.find_one('path', query={'_id': ObjectId(path_id)})

        if not path:
            return Response('PATH_NOT_FOUND', status=status.HTTP_404_NOT_FOUND)

        text=""
        text+=path["description"]+"\n"
        text+=path["description"]+"\n" #intentionally added twice to make it more important
        for m in path["milestones"]:
            text+=m["title"]+"\n"
            text+=m["title"]+"\n" # included twice to emphasize
            text+=m["body"]+"\n"

        topics=path["topics"]
        topicnames=[topicname(t) for t in topics]

        res=wordcloudgen(text,topicnames,width=width,height=height)
        res=base64.b64encode(res)
        #res="data:image/png;base64"+res.decode()
        res=res.decode()
        return Response(res,status=status.HTTP_200_OK)

class GetPath(APIView):
    permission_classes = [IsAuthenticated]

    def get(self, request, path_id):
        data = request.data
        username = data['username']

        with MongoDBHelper(uri=settings.MONGO_URI, database=settings.DB_NAME) as db:
            path = db.find_one('path', query={'_id': ObjectId(path_id)}, projection={'_id': 0})
            follow = db.find_one('follow_path', query={'username': username, 'path_id': path_id})
            enroll = db.find_one('enroll', query={'username': username, 'path_id': path_id})

        path['isFollowed'] = follow is not None
        path['isEnrolled'] = enroll is not None

        return Response(path)

class GetRelatedPath(APIView):
    permission_classes = [IsAuthenticated]

    def get(self, request, topic_id):
        data = request.data
        username = data['username']

        topics = get_related_topics(topic_id)
        
        with MongoDBHelper(uri=settings.MONGO_URI, database=settings.DB_NAME) as db:
            paths = list(db.find('path', query={'topic': {'$not': {'$q': {'$nin': topics}}}})) # check
            followedPaths = list(db.find('follow_path', query={'username': username}, projection={'_id': 0}))
            enrolledPaths = list(db.find('enroll', query={'username': username},  projection={'_id': 0}))

        for path in paths:
            path['_id'] = str(path['_id'])
            path['isFollowed'] = False
            path['isEnrolled'] = False

        for followed_path in followedPaths:
            for path in paths:
                if path['_id'] == followed_path['path_id']:
                    path['isFollowed'] = True

        for enrolled_path in enrolledPaths:
            for path in paths:
                if path['_id'] == enrolled_path['path_id']:
                    path['isEnrolled'] = True

        return Response(paths, status=status.HTTP_200_OK)

class FollowPath(APIView):
    permission_classes = [IsAuthenticated]

    """ requests username and path_id and responses success or fail message, tested"""
    def post(self, request):
        data = request.data
        username = data['username']
        target = data['path_id']

        with MongoDBHelper(uri=settings.MONGO_URI, database=settings.DB_NAME) as db:
            relation = db.find_one('follow_path', {
                'username': username,
                'path_id': target,
            })

            if relation:
                return Response('ALREADY_FOLLOWED', status=status.HTTP_409_CONFLICT)

            db.insert_one('follow_path', {
                'username': username,
                'path_id': target,
            })

        return Response('SUCCESSFUL')


class UnfollowPath(APIView):
    permission_classes = [IsAuthenticated]

    """ requests username and path_id and responses success or fail message, tested"""
    def post(self, request):
        data = request.data
        username = data['username']
        target = data['path_id']

        with MongoDBHelper(uri=settings.MONGO_URI, database=settings.DB_NAME) as db:
            relation = db.find_one('follow_path', {
                'username': username,
                'path_id': target,
            })

            if not relation:
                return Response('NOT_FOLLOWED', status=status.HTTP_409_CONFLICT)

            db.delete_one('follow_path', {
                'username': username,
                'path_id': target,
            })

        return Response('SUCCESSFUL')


class GetFollowedPaths(APIView):
    permission_classes = [IsAuthenticated]

    """ requests username and returns all followed paths of the given username, tested """
    def get(self, request):
        data = request.data
        username = data['username']

        with MongoDBHelper(uri=settings.MONGO_URI, database=settings.DB_NAME) as db:
            followedPaths = list(db.find('follow_path', query={'username': username}, projection={'_id': 0}))
            allPaths = list(db.find('path', query={'_id': {'$in': [ObjectId(path['path_id']) for path in followedPaths]}}, projection={'_id': 0}))

        return Response(
            {
                'enrolledPaths': [path for path in zip(followedPaths, allPaths)]
            },
            status=status.HTTP_200_OK
        )


class SearchPath(APIView):
    permission_classes = [IsAuthenticated]

    def get(self, request, search_text):
        data = request.data
        username = data['username']
                
        with MongoDBHelper(uri=settings.MONGO_URI, database=settings.DB_NAME) as db:
            paths = list(db.find(
                'path',  # TODO Create fulltext index on subtexts
                query={'$or': [{'$text': {'$search': search_text}},
                               {'title': {'$regex': search_text, '$options': 'i'}}]},
                projection={}
            ).limit(10))

            followedPaths = list(db.find('follow_path', query={'username': username}, projection={'_id': 0}))
            enrolledPaths = list(db.find('enroll', query={'username': username},  projection={'_id': 0}))

        for path in paths:
            path['_id'] = str(path['_id'])
            path['isFollowed'] = False
            path['isEnrolled'] = False

        for followed_path in followedPaths:
            for path in paths:
                if path['_id'] == followed_path['path_id']:
                    path['isFollowed'] = True

        for enrolled_path in enrolledPaths:
            for path in paths:
                if path['_id'] == enrolled_path['path_id']:
                    path['isEnrolled'] = True

        return Response(paths, status=status.HTTP_200_OK)

