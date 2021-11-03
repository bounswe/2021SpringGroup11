import jwt
import time
from rest_framework.permissions import BasePermission
from rest_framework.exceptions import NotAuthenticated, PermissionDenied
from django.conf import settings

class IsAuthenticated(BasePermission):
    """
        Allows access only to authenticated users.
        Adds params&jwt data into request.data 
    """

    def has_permission(self, request, view):
        if request.GET:
            for key in request.query_params.keys():
                value = request.query_params.getlist(key)
                
                if len(value) == 1:
                    request.data.update({key.replace('[]', ''): value[0]})
                elif len(value)== 0:
                    request.data.update({key.replace('[]', ''): []})
                else:
                    request.data.update({key.replace('[]', ''): value})
        
        token_info = verify_jwt_token(request.META.get('HTTP_AUTHORIZATION'))
        if token_info:
            request.data.update({'email': token_info['email']})
            request.data.update({'username': token_info['username']})
            # request.data.update({'isAdmin': token_info['isAdmin']})
            return True
        else:
            raise NotAuthenticated('No credentials provided for request')

class IsAdmin(BasePermission):
    """
        Allows access only to admin users.
        Adds params&jwt data into request.data 
    """

    def has_permission(self, request, view):
        token_info = verify_jwt_token(request.META.get('HTTP_AUTHORIZATION'))
        if token_info:
            request.data.update({'isAdmin': token_info['isAdmin']})
            
            return token_info['isAdmin']
        else:
            raise NotAuthenticated('No credentials provided for request')

def verify_jwt_token(token):
    """
        verifies token and returns decoded jwt
        :token: jwt token
        return decoded token
    """
    try:
        token = token.replace('Bearer ', '')
        data = decode_jwt(token)

        if data['exp'] < time.time():
            raise PermissionDenied('Token is not valid')
        
        return data
    except:
        raise PermissionDenied('Token is not valid')

def create_jwt(data: dict):
    """
        Returns encoded jwt
        :data: dict
    """
    return jwt.encode(data, settings.SECRET_KEY, algorithm='HS256')

def decode_jwt(encoded_jwt):
    """
        Returns decoded jwt
        :encoded_jwt: jwt
    """
    if isinstance(encoded_jwt, str):
        encoded_jwt = encoded_jwt.encode()
    
    return jwt.decode(encoded_jwt, settings.SECRET_KEY, algorithms=['HS256'])