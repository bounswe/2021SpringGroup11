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

class EditUserTest(TestCase):
    def setUp(self):
        self.client = Client()

    def test_post_200_code(self):
        data = {'bio': 'test user'}
    
        response = self.client.post(
            reverse('edit_user'),
            data,
            **AUTHENTICATED_NORMALUSER_HEADERS,
            content_type="application/json"
        )
        
        self.assertEquals(response.status_code, 200)
    
    def test_403_code(self):
        data = {'bio': 'test user'}
    
        response = self.client.post(
            reverse('edit_user'),
            data,
            **UNAUTHENTICATED_NORMALUSER_HEADERS,
            content_type="application/json"
        )
        
        self.assertEquals(response.status_code, 403)
    
    def test_400_code(self):
        data = {'bio': 'test user'}
    
        response = self.client.post(
            reverse('edit_user'),
            data,
            **AUTHENTICATED_DELETEDUSER_HEADERS,
            content_type="application/json"
        )
        
        self.assertEquals(response.status_code, 400)


class SearchUserTest(TestCase):
    def setUp(self):
        self.client = Client()

    def test_200_code(self):
        response = self.client.get(
            reverse('search_user', kwargs={'search_text': 'test'})
        )

        self.assertEquals(response.status_code, 200)

"""
class BanUserTest(TestCase):
    def setUp(self):
        self.client = Client()
    
    def test_200_code(self):
        data = {'username': 'banned_user'}
    
        response = self.client.post(
            reverse('ban_user'),
            data,
            **AUTHENTICATED_NORMALUSER_HEADERS,
            content_type="application/json"
        )
        
        self.assertEquals(response.status_code, 200)
"""