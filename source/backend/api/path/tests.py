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
                'topics': [{"ID": 2}],
                'creator_username': 'test user',
                'photo': '',
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
                'topics': [{"ID": 2}],
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
            reverse('get_path', kwargs={'path_id': '61b8810965643a8f4f895247'}),
            **AUTHENTICATED_NORMALUSER_HEADERS,
            content_type="application/json"
        )
        
        self.assertEquals(response.status_code, 200)

    def test_403_code(self):
        response = self.client.get(
            reverse('get_path', kwargs={'path_id': '61b8810965643a8f4f895247'}),
            **UNAUTHENTICATED_NORMALUSER_HEADERS,
            content_type="application/json"
        )
        
        self.assertEquals(response.status_code, 403)

class MyPaths(TestCase):
    def setUp(self):
        self.client = Client()
    
    def test_200_code(self):
        response = self.client.get(
            reverse('my_paths'),
            **AUTHENTICATED_NORMALUSER_HEADERS,
            content_type="application/json"
        )
        
        self.assertEquals(response.status_code, 200)

    def test_403_code(self):
        response = self.client.get(
            reverse('my_paths'),
            **UNAUTHENTICATED_NORMALUSER_HEADERS,
            content_type="application/json"
        )
        
        self.assertEquals(response.status_code, 403)

class EditPathTest(TestCase):
    def setUp(self):
        self.client = Client()

    def test_post_200_code(self):
        data = {'title': 'test title',
                'pathID' :  "61b864fffc7b6ca95de23214",
                'description': 'test description',
                'topics': [{"ID": 2}],
                'photo': '',
                'milestones': [{"title": "My earth is very earth", 
                                "body": "Earth"}],
                }
    
        response = self.client.post(
            reverse('edit_path'),
            data,
            **AUTHENTICATED_NORMALUSER_HEADERS,
            content_type="application/json"
        )
        
        self.assertEquals(response.status_code, 200)
    
    def test_403_code(self):
        data = {'title': 'test title',
                'pathID' :  "61b864fffc7b6ca95de23214",
                'description': 'test description',
                'topics': [{"ID": 2}],
                'photo': '',
                'milestones': [{"title": "My earth is very earth", 
                                "body": "Earth"}],
                }
    
        response = self.client.post(
            reverse('edit_path'),
            data,
            **UNAUTHENTICATED_NORMALUSER_HEADERS,
            content_type="application/json"
        )
        
        self.assertEquals(response.status_code, 403)

class RatePathTest(TestCase):
    def setUp(self):
        self.client = Client()

    def test_post_200_code(self):
        data = {
                'path_id' :  "61b864fffc7b6ca95de23214",
                'rating': 3.2
                }
    
        response = self.client.post(
            reverse('rate_path'),
            data,
            **AUTHENTICATED_NORMALUSER_HEADERS,
            content_type="application/json"
        )
        
        self.assertEquals(response.status_code, 200)
    
    def test_403_code(self):
        data = {
                'path_id' :  "61b864fffc7b6ca95de23214",
                'rating': 3.2
                }
    
        response = self.client.post(
            reverse('rate_path'),
            data,
            **UNAUTHENTICATED_NORMALUSER_HEADERS,
            content_type="application/json"
        )
        
        self.assertEquals(response.status_code, 403)


class EffortPathTest(TestCase):
    def setUp(self):
        self.client = Client()

    def test_post_200_code(self):
        data = {
                'path_id' :  "61b864fffc7b6ca95de23214",
                'effort': 3.2
                }
    
        response = self.client.post(
            reverse('effort_path'),
            data,
            **AUTHENTICATED_NORMALUSER_HEADERS,
            content_type="application/json"
        )
        
        self.assertEquals(response.status_code, 200)
    
    def test_403_code(self):
        data = {
                'path_id' :  "61b864fffc7b6ca95de23214",
                'effort': 3.2
                }
    
        response = self.client.post(
            reverse('effort_path'),
            data,
            **UNAUTHENTICATED_NORMALUSER_HEADERS,
            content_type="application/json"
        )
        
        self.assertEquals(response.status_code, 403)

class FollowPathTest(TestCase):
    def setUp(self):
        self.client = Client()

    def test_post_200_code(self):
        data = {
                'path_id' :  "61b864fffc7b6ca95de23214",
                }
    
        response = self.client.post(
            reverse('follow_path'),
            data,
            **AUTHENTICATED_NORMALUSER_HEADERS,
            content_type="application/json"
        )
        
        self.assertEquals(response.status_code, 200)
    
    def test_403_code(self):
        data = {
                'path_id' :  "61b864fffc7b6ca95de23214",
                }
    
        response = self.client.post(
            reverse('follow_path'),
            data,
            **UNAUTHENTICATED_NORMALUSER_HEADERS,
            content_type="application/json"
        )
        
        self.assertEquals(response.status_code, 403)
    
    def test_post_409_code(self):
        data = {
                'path_id' :  "61b864fffc7b6ca95de23214",
                }
    
        response = self.client.post(
            reverse('follow_path'),
            data,
            **AUTHENTICATED_NORMALUSER_HEADERS,
            content_type="application/json"
        )
        
        self.assertEquals(response.status_code, 409)

class UnFollowPathTest(TestCase):
    def setUp(self):
        self.client = Client()

    def test_post_200_code(self):
        data = {
                'path_id' :  "61b864fffc7b6ca95de23214",
                }
    
        response = self.client.post(
            reverse('unfollow_path'),
            data,
            **AUTHENTICATED_NORMALUSER_HEADERS,
            content_type="application/json"
        )
        
        self.assertEquals(response.status_code, 200)
    
    def test_403_code(self):
        data = {
                'path_id' :  "61b864fffc7b6ca95de23214",
                }
    
        response = self.client.post(
            reverse('unfollow_path'),
            data,
            **UNAUTHENTICATED_NORMALUSER_HEADERS,
            content_type="application/json"
        )
        
        self.assertEquals(response.status_code, 403)
    
    def test_post_409_code(self):
        data = {
                'path_id' :  "61b864fffc7b6ca95de23214",
                }
    
        response = self.client.post(
            reverse('unfollow_path'),
            data,
            **AUTHENTICATED_NORMALUSER_HEADERS,
            content_type="application/json"
        )
        
        self.assertEquals(response.status_code, 409)
