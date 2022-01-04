from django.test import TestCase, Client
from django.urls import reverse
from heybooster.helpers.database.mongodb import MongoDBHelper
from django.conf import settings
import random


class SignupTests(TestCase):
    def setUp(self):
        self.client = Client()

    def test_base_case(self):
        data = {
            "email": f'baduser{random.random()}@example.com',
            "username": "baduser12312312312312312312313" + str(random.random()),
            "firstname": "bad",
            "lastname": "user",
            "password": "asd123",
        }
        response = self.client.post(
            reverse('signup'),
            data,
            content_type="application/json"
        )
        with MongoDBHelper(uri=settings.MONGO_URI, database=settings.DB_NAME) as db:
            db.remove("user", query={"username": data["username"]})
        self.assertEquals(response.status_code, 200)

    def test_missing_name(self):
        data={
            "email":f'baduser{random.random()}@example.com',
            "username":"baduser12312312312312312312313"+str(random.random()),
            "lastname":"user",
            "password":"asd123"
        }
        response = self.client.post(
            reverse('signup'),
            data,
            content_type="application/json"
        )
        with MongoDBHelper(uri=settings.MONGO_URI, database=settings.DB_NAME) as db:
            db.remove("user",query={"username":data["username"]})
        self.assertEquals(response.status_code, 400)

    def test_extra_argument(self):
        data = {
            "email": f'baduser{random.random()}@example.com',
            "username": "baduser12312312312312312312313"+str(random.random()),
            "firstname": "bad",
            "lastname": "user",
            "password": "asd123",
            "favorite_color":"blue"  #this is not necessary but should not cause an error
        }
        response = self.client.post(
            reverse('signup'),
            data,
            content_type="application/json"
        )
        with MongoDBHelper(uri=settings.MONGO_URI, database=settings.DB_NAME) as db:
            db.remove("user",query={"username":data["username"]})
        self.assertEquals(response.status_code, 200)

    def test_existing_username(self):
        data = {
            "email": f'baduser{random.random()}@example.com',
            "username": "baduser12312312312312312312313",
            "firstname": "bad",
            "lastname": "user",
            "password": "asd123"
        }
        response = self.client.post(
            reverse('signup'),
            data,
            content_type="application/json"
        )
        response = self.client.post(
            reverse('signup'),
            data,
            content_type="application/json"
        )
        with MongoDBHelper(uri=settings.MONGO_URI, database=settings.DB_NAME) as db:
            db.remove("user",query={"username":data["username"]})
        self.assertEquals(response.status_code, 406)

    def test_existing_email(self):
        data = {
            "email": f'baduser@example.com',
            "username": "baduser12312312312312312312313"+str(random.random()),
            "firstname": "bad",
            "lastname": "user",
            "password": "asd123"
        }
        response = self.client.post(
            reverse('signup'),
            data,
            content_type="application/json"
        )
        response = self.client.post(
            reverse('signup'),
            data,
            content_type="application/json"
        )
        with MongoDBHelper(uri=settings.MONGO_URI, database=settings.DB_NAME) as db:
            db.remove("user",query={"username":data["username"]})
        self.assertEquals(response.status_code, 406)


class LoginTests(TestCase):
    def setUp(self):
        self.client = Client()

    def test_base_case(self):
        data = {
            "email": f'baduser{random.random()}@example.com',
            "username": "baduser12312312312312312312313" + str(random.random()),
            "firstname": "bad",
            "lastname": "user",
            "password": "asd123",
        }
        self.client.post(
            reverse('signup'),
            data,
            content_type="application/json"
        )

        response=self.client.post(
            reverse('login'),
            {"username":data["username"],"password":data["password"]},
            content_type="application/json"
        )

        with MongoDBHelper(uri=settings.MONGO_URI, database=settings.DB_NAME) as db:
            db.remove("user", query={"username": data["username"]})

        self.assertEquals(response.status_code, 200)

    def test_wrong_password(self):
        data = {
            "email": f'baduser{random.random()}@example.com',
            "username": "baduser12312312312312312312313" + str(random.random()),
            "firstname": "bad",
            "lastname": "user",
            "password": "asd123"+str(random.random()),
        }
        self.client.post(
            reverse('signup'),
            data,
            content_type="application/json"
        )

        response = self.client.post(
            reverse('login'),
            {"username": data["username"], "password": "asd123"+str(random.random())},
            content_type="application/json"
        )

        with MongoDBHelper(uri=settings.MONGO_URI, database=settings.DB_NAME) as db:
            db.remove("user", query={"username": data["username"]})

        self.assertEquals(response.status_code, 401)

    def test_wrong_username(self):
        data = {
            "email": f'baduser{random.random()}@example.com',
            "username": "baduser12312312312312312312313" + str(random.random()),
            "firstname": "bad",
            "lastname": "user",
            "password": "asd123"+str(random.random()),
        }
        response = self.client.post(
            reverse('login'),
            {"username": data["username"], "password": data["password"]},
            content_type="application/json"
        )
        self.assertEquals(response.status_code, 400)

    def test_no_username(self):
        data = {
            "email": f'baduser{random.random()}@example.com',
            "username": "baduser12312312312312312312313" + str(random.random()),
            "firstname": "bad",
            "lastname": "user",
            "password": "asd123"+str(random.random()),
        }
        response = self.client.post(
            reverse('login'),
            {"password": data["password"]},
            content_type="application/json"
        )
        self.assertEquals(response.status_code, 400)

    def test_extra_field(self):
        data = {
            "email": f'baduser{random.random()}@example.com',
            "username": "baduser12312312312312312312313" + str(random.random()),
            "firstname": "bad",
            "lastname": "user",
            "password": "asd123",
        }
        self.client.post(
            reverse('signup'),
            data,
            content_type="application/json"
        )

        response=self.client.post(
            reverse('login'),
            {"username":data["username"],"password":data["password"],"favorite_color":"blue"},
            content_type="application/json"
        )

        with MongoDBHelper(uri=settings.MONGO_URI, database=settings.DB_NAME) as db:
            db.remove("user", query={"username": data["username"]})

        self.assertEquals(response.status_code, 200)
