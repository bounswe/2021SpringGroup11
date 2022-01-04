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

class FavoriteTopicTest(TestCase):
    def setUp(self):
        self.client = Client()

    def test_200_code(self):
        data = {'ID': 2}
    
        response = self.client.post(
            reverse('favorite_topic'),
            data,
            **AUTHENTICATED_NORMALUSER_HEADERS,
            content_type="application/json"
        )
        
        self.assertEquals(response.status_code, 200)
    
    def test_403_code(self):
        data = {'ID': 2}
    
        response = self.client.post(
            reverse('favorite_topic'),
            data,
            **UNAUTHENTICATED_NORMALUSER_HEADERS,
            content_type="application/json"
        )
        
        self.assertEquals(response.status_code, 403)
    
    def test_409_code(self):
        data = {'ID': 2}
    
        response = self.client.post(
            reverse('favorite_topic'),
            data,
            **AUTHENTICATED_NORMALUSER_HEADERS,
            content_type="application/json"
        )
        
        self.assertEquals(response.status_code, 409)

class UnfavoriteTopicTest(TestCase):
    def setUp(self):
        self.client = Client()

    def test_200_code(self):
        data = {'ID': 2}
    
        response = self.client.post(
            reverse('unfavorite_topic'),
            data,
            **AUTHENTICATED_NORMALUSER_HEADERS,
            content_type="application/json"
        )
        
        self.assertEquals(response.status_code, 200)
    
    def test_403_code(self):
        data = {'ID': 2}
    
        response = self.client.post(
            reverse('unfavorite_topic'),
            data,
            **UNAUTHENTICATED_NORMALUSER_HEADERS,
            content_type="application/json"
        )
        
        self.assertEquals(response.status_code, 403)
    
    def test_409_code(self):
        data = {'ID': 2}
    
        response = self.client.post(
            reverse('unfavorite_topic'),
            data,
            **AUTHENTICATED_NORMALUSER_HEADERS,
            content_type="application/json"
        )
        
        self.assertEquals(response.status_code, 409)

class SearchTopicTest(TestCase):
    def setUp(self):
        self.client = Client()

    def test_200_code(self):
        data = {'ID': 2}
    
        response = self.client.get(
            reverse('search_topic', kwargs={'search_text': 'earth'}),
            data,
            **AUTHENTICATED_NORMALUSER_HEADERS,
            content_type="application/json"
        )
        
        self.assertEquals(response.status_code, 200)
    
    def test_403_code(self):
        data = {'ID': 2}
    
        response = self.client.get(
            reverse('search_topic', kwargs={'search_text': 'earth'}),
            data,
            **UNAUTHENTICATED_NORMALUSER_HEADERS,
            content_type="application/json"
        )
        
        self.assertEquals(response.status_code, 403)

class GetTopicTest(TestCase):
    def setUp(self):
        self.client = Client()

    def test_200_code(self):
        data = {'ID': 2}
    
        response = self.client.get(
            reverse('get_topic', kwargs={'topic_id': '2'}),
            data,
            **AUTHENTICATED_NORMALUSER_HEADERS,
            content_type="application/json"
        )
        
        self.assertEquals(response.status_code, 200)
    
    def test_403_code(self):
        data = {'ID': 2}
    
        response = self.client.get(
            reverse('get_topic', kwargs={'topic_id': '2'}),
            data,
            **UNAUTHENTICATED_NORMALUSER_HEADERS,
            content_type="application/json"
        )
        
        self.assertEquals(response.status_code, 403)

class RelatedTopicTest(TestCase):
    def setUp(self):
        self.client = Client()

    def test_200_code(self):
        data = {'ID': 2}
    
        response = self.client.get(
            reverse('related_topic', kwargs={'topic_id': '2'}),
            data,
            **AUTHENTICATED_NORMALUSER_HEADERS,
            content_type="application/json"
        )
        
        self.assertEquals(response.status_code, 200)
    
    def test_403_code(self):
        data = {'ID': 2}
    
        response = self.client.get(
            reverse('related_topic', kwargs={'topic_id': '2'}),
            data,
            **UNAUTHENTICATED_NORMALUSER_HEADERS,
            content_type="application/json"
        )
        
        self.assertEquals(response.status_code, 403)

class MyTopicsTest(TestCase):
    def setUp(self):
        self.client = Client()

    def test_200_code(self):
        data = {'ID': 2}
    
        response = self.client.get(
            reverse('my_topics'),
            data,
            **AUTHENTICATED_NORMALUSER_HEADERS,
            content_type="application/json"
        )
        
        self.assertEquals(response.status_code, 200)
    
    def test_403_code(self):
        data = {'ID': 2}
    
        response = self.client.get(
            reverse('my_topics'),
            data,
            **UNAUTHENTICATED_NORMALUSER_HEADERS,
            content_type="application/json"
        )
        
        self.assertEquals(response.status_code, 403)
