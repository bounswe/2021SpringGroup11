from django.test import TestCase, Client
from django.urls import reverse
from heybooster.helpers.database.mongodb import MongoDBHelper
from django.conf import settings

import time
import random
from authentication.utils import create_jwt


class SignupTests(TestCase):
    def setUp(self):
        self.client = Client()

    def base_case(self):
        def extra_argument(self):
            data = {
                "email": "baduser@example.com",
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
                db.delete("user", query={"username": data["username"]})
            self.assertEquals(response.status_code, 200)

    def missing_name(self):
        data={
            "email":"baduser@example.com",
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
            db.delete("user",query={"username":data["username"]})
        self.assertEquals(response.status_code, 400)

    def extra_argument(self):
        data = {
            "email": "baduser@example.com",
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
            db.delete("user",query={"username":data["username"]})
        self.assertEquals(response.status_code, 200)

    def existing_username(self):
        data = {
            "email": "baduser@example.com",
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
            db.delete("user",query={"username":data["username"]})
        self.assertEquals(response.status_code, 406)

