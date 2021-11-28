import time
from rest_framework import status
from rest_framework.response import Response
from rest_framework.views import APIView
from authentication.utils import create_jwt, decode_jwt, send_email, create_forgot_password_link
from heybooster.helpers.database.mongodb import MongoDBHelper
from django.conf import settings
from common.data_check import check_data_keys
from common.models import User


class SignUp(APIView):
    
    def post(self, request):
        data = request.data
        key_error = check_data_keys(data=data, necessary_keys=['email', 'username', 'firstname', 'lastname', 'password'])

        if key_error:
            return Response({'detail': key_error}, status.HTTP_400_BAD_REQUEST)

        with MongoDBHelper(uri=settings.MONGO_URI, database=settings.DB_NAME) as db:
            if db.find_one('user', query={'$or': [{'email': data['email']}, {'username': data['username']}]}):
                return Response({'detail': 'USERNAME_ALREADY_EXISTS'}, status=status.HTTP_406_NOT_ACCEPTABLE)
        
        user = User(**data)
        user.hash_password()
        user.insert()

        send_email(data['email'], data['username'])

        return Response({'detail': 'USER_CREATED'}, status=status.HTTP_200_OK)


class LogIn(APIView):
    
    def post(self, request):
        data = request.data
        key_error = check_data_keys(data=data, necessary_keys=['username', 'password'])

        if key_error:
            return Response({'detail': key_error}, status.HTTP_400_BAD_REQUEST)

        with MongoDBHelper(uri=settings.MONGO_URI, database=settings.DB_NAME) as db:
            user = db.find_one('user', query={'username': data['username']})
            
        if not user or user['isBanned']:
            return Response({'detail': 'NO_USER'}, status=status.HTTP_400_BAD_REQUEST)

        user = User(**user)
        
        if not user.check_password(password=data['password']):
            return Response({'detail': 'WRONG_PASSWORD'}, status=status.HTTP_401_UNAUTHORIZED)

        user.lastLogin = int(time.time())
        user.update()

        return Response(
            create_jwt({
                'username': user.username,
                'email': user.email,
                'isAdmin': user.isAdmin,
                'exp': int(time.time()) + 60*60
                })
        , status=status.HTTP_200_OK)


class RefreshToken(APIView):

    def post(self, request):
        data = request.data
        
        if data.get('jwt'):
            token_info = decode_jwt(data['jwt'])
            token_info.pop('exp')

            with MongoDBHelper(uri=settings.MONGO_URI, database=settings.DB_NAME) as db:
                user = db.find_one('user', query=token_info)

            if user:
                token_info['exp'] = int(time.time()) + 60*60
                token_info['isAdmin'] = user['isAdmin']

                return Response(create_jwt(token_info), status.HTTP_200_OK)
        else:
            try:
                email = data['email']
            except:
                try:
                    email = request.session.get('email')
                except:
                    email = request.COOKIES.get('email')

            if email:
                with MongoDBHelper(uri=settings.MONGO_URI, database=settings.DB_NAME) as db:
                    user = db.find_one('user', query={'email': email, 'rememberMe': True})
                
                if user:
                    return Response(
                        create_jwt({
                            'username': user['username'],
                            'email': user['email'],
                            'isAdmin': user['isAdmin'],
                            'exp': int(time.time()) + 60*60
                            })
                    , status=status.HTTP_200_OK)
        
        return Response({'detail': 'REFRESH_FAILED'},status=status.HTTP_400_BAD_REQUEST)


class ForgotPassword(APIView):
    """
        Forgot Password API
    """

    def post(self, request):
        data = request.data
        key_error = check_data_keys(data=data, necessary_keys=['username'])
        
        if key_error:
            return Response({'detail': key_error}, status.HTTP_400_BAD_REQUEST)
        
        with MongoDBHelper(uri=settings.MONGO_URI, database=settings.DB_NAME) as db:
            user = db.find_one('user', query={'username': data['username']})
        
        if not user or user.get('isDeleted'):
            return Response({'detail': 'USER_NOT_FOUND'}, status=status.HTTP_404_NOT_FOUND)

        if user['isBanned']:
            return Response({'detail': 'USER_IS_BANNED'}, status=status.HTTP_400_BAD_REQUEST)

        link = create_forgot_password_link(jwt=create_jwt(
            {
                'username': user['username'],
                'email': user['email'],
                'isAdmin': user['isAdmin'],
                'exp': int(time.time()) + 60*60
            }
        ))
        send_email(receiver=user['email'], username=user['username'], forgot_password_link=link)

        return Response('EMAIL_SENT', status=status.HTTP_202_ACCEPTED)
