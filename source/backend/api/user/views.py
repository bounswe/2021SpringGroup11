from rest_framework import status
from rest_framework.response import Response
from rest_framework.views import APIView
from authentication.utils import IsAuthenticated, IsAdmin
from heybooster.helpers.database.mongodb import MongoDBHelper
from django.conf import settings
from common.models import User
from common.data_check import check_data_keys

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
                projection={'username': 1}
            )

        return Response(users, status=status.HTTP_200_OK)


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
        user.update()

        return Response(user.get_dict(), status=status.HTTP_200_OK)