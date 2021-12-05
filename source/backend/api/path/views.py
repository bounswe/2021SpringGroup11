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


class CreatePath(APIView):
    permission_classes = [IsAuthenticated]
    
    def post(request):
        data = request.data

        title = data['title']
        description = data['description']
        topics = data['topics']
        creator_username = data['username']
        creator_email = data['email']
        created_at = time.time()
        images = data['images']
        thumbnail = data['thumbnail']
        milestones = data['milestones'] # title and body
        comments = data['comments']
        is_banned = False
        

        return Response('')

class RatePath(APIView):
    permission_classes = [IsAuthenticated]

    def post(request):
        data = request.data

        rating = data['rating']
        path_id = data['path_id']
        username = data['username']

        with MongoDBHelper(uri=settings.MONGO_URI, database=settings.DB_NAME) as db:
            db.insert_one('pathRating',
            {
                'username': username,
                'path_id': path_id,
                'rating': rating,
            })
        
        return Response('Successful')

class EffortPath(APIView):
    permission_classes = [IsAuthenticated]

    def post(request):
        data = request.data

        effort = data['effort']
        path_id = data['path_id']
        username = data['username']

        with MongoDBHelper(uri=settings.MONGO_URI, database=settings.DB_NAME) as db:
            db.insert_one('pathEffort',
            {
                'username': username,
                'path_id': path_id,
                'effort': effort,
            })
    
        return Response('Successful')

class GetPathDetail(APIView):
    permission_classes = [IsAuthenticated]

    def post(request):
        data = request.data 

        path_id = data['path_id']
        username = data['username']

        rating = 0
        effort = 0

        with MongoDBHelper(uri=settings.MONGO_URI, database=settings.DB_NAME) as db:
            rates = list(db.find('pathRating', query={'path_id': path_id}))
            efforts = list(db.find('pathEffort', query={'path_id': path_id}))

        for rate in rates:
            rating += rate['rating']
        if rates:
            rating /= len(rates)

        for effort_document in efforts:
            effort += effort_document['effort']
        if efforts:
            effort /= len(efforts)

        return Response({
            'rating': rating,
            'effort': effort,
        }, status=status.HTTP_200_OK)

class SearchTopic(APIView):

    def post(request):
        data = request.data

        search = data['search']

        with MongoDBHelper(uri=settings.MONGO_URI, database=settings.DB_NAME) as db:
            topics = db.find('')# full text + regex search
        
        return Response(list(topics), status=status.HTTP_200_OK)


