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

class FavoriteTopic(APIView):
    permission_classes = [IsAuthenticated]

    def post(self, request):
        data = request.data
        username = data['username']
        target = data['ID']

        with MongoDBHelper(uri=settings.MONGO_URI, database=settings.DB_NAME) as db:
            relation = db.find_one('favorite', {
                'username': username,
                'ID': target,
            })

            if relation:
                return Response('ALREADY_FAVORITE', status=status.HTTP_409_CONFLICT)

            db.insert_one('favorite', {
                'username': username,
                'ID': target,
            })

        return Response('SUCCESSFUL')


class UnFavoriteTopic(APIView):
    permission_classes = [IsAuthenticated]

    def post(self, request):
        data = request.data
        username = data['username']
        target = data['ID']

        with MongoDBHelper(uri=settings.MONGO_URI, database=settings.DB_NAME) as db:
            relation = db.find_one('favorite', {
                'username': username,
                'ID': target,
            })

            if not relation:
                return Response('NOT_FAVORITE', status=status.HTTP_409_CONFLICT)

            db.delete_one('favorite', {
                'username': username,
                'ID': target,
            })

        return Response('SUCCESSFUL')
