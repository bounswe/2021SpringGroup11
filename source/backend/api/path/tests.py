import time
from django.test import TestCase, Client
from django.urls import reverse
from authentication.utils import create_jwt

NORMALUSER_JWT_DATA = {
    'username': "test",
    'email': "test@test.com",
    'isAdmin': False,
    'exp': int(time.time()) + 60*60*24
}

DELETEDUSER_JWT_DATA = {
    'username': "test_deleted",
    'email': "test@test.com",
    'isAdmin': False,
    'exp': int(time.time()) + 60*60*24
}

ADMINUSER_JWT_DATA = {
    'username': "test_admin",
    'email': "test@test.com",
    'isAdmin': True,
    'exp': int(time.time()) + 60*60*24
}


AUTHENTICATED_NORMALUSER_HEADERS = {
    "HTTP_AUTHORIZATION": create_jwt(NORMALUSER_JWT_DATA),
}

AUTHENTICATED_DELETEDUSER_HEADERS = {
    "HTTP_AUTHORIZATION": create_jwt(DELETEDUSER_JWT_DATA),
}

AUTHENTICATED_ADMINUSER_HEADERS = {
    "HTTP_AUTHORIZATION": create_jwt(ADMINUSER_JWT_DATA),
}

UNAUTHENTICATED_NORMALUSER_HEADERS = {
    "HTTP_AUTHORIZATION": "some-invalid-key"
}

class CreatePathTest(TestCase):
    def setUp(self):
        self.client = Client()

    def test_post_200_code(self):
        data = {'title': 'test title', 
                'description': 'test description',
                'topics': [2], #?
                'creator_username': 'test user',
                'photo': '', #?
                'milestones': [{"title": "My earth is very earth", 
                                "body": "Earth"}],
                'is_banned': 'false',
                'is_deleted': 'false'
                }
    
        response = self.client.post(
            reverse('create_path'),
            data,
            **AUTHENTICATED_NORMALUSER_HEADERS,
            content_type="application/json"
        )
        
        self.assertEquals(response.status_code, 200)
    
    def test_403_code(self):
        data = {'title': 'test title', 
                'description': 'test description',
                'topics': [2], #?
                'creator_username': 'test user',
                'photo': '', #?
                'milestones': [{"title": "My earth is very earth", 
                                "body": "Earth"}],
                'is_banned': 'false',
                'is_deleted': 'false'
                }
    
        response = self.client.post(
            reverse('create_path'),
            data,
            **UNAUTHENTICATED_NORMALUSER_HEADERS,
            content_type="application/json"
        )
        
        self.assertEquals(response.status_code, 403)


class GetPathTest(TestCase):
    def setUp(self):
        self.client = Client()
    
    def test_200_code(self):
        response = self.client.get(
            reverse('get_path'),
            **AUTHENTICATED_NORMALUSER_HEADERS,
            content_type="application/json"
        )
        
        self.assertEquals(response.status_code, 200)

    def test_403_code(self):
        response = self.client.get(
            reverse('get_path'),
            **UNAUTHENTICATED_NORMALUSER_HEADERS,
            content_type="application/json"
        )
        
        self.assertEquals(response.status_code, 403)