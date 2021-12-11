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
    # permission_classes = [IsAuthenticated]
    
    def post(self, request):
        data = request.data

        title = data['title']
        description = data['description']
        topics = data['topics']
        creator_username = data['username']
        creator_email = data['email']
        created_at = time.time()
        #images = data['images']
        #thumbnail = data['thumbnail']
        photo = data['photo']
        milestones = data['milestones'] # title and body
        # comments = data['comments']
        is_banned = False
        is_deleted = False

        with MongoDBHelper(uri=settings.MONGO_URI, database=settings.DB_NAME) as db:
            id = db.insert_one('path',
            {
                'title': title,
                'description': description,
                'topics': topics,
                'creator_username': creator_username,
                'creator_email': creator_email,
                'created_at': created_at,
                'photo': photo,
                'milestones': milestones,
                'is_banned': is_banned,
                'is_deleted': is_deleted
            }).inserted_id

        return Response({'pathID': str(id)}, status=status.HTTP_200_OK)

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

class GetFollow(APIView):
    permission_classes = [IsAuthenticated]
    
    def get(request):
        data = request.data

        username = data['username']

        with MongoDBHelper(uri=settings.MONGO_URI, database=settings.DB_NAME) as db:
            followers = list(db.find('follow', query={'followed_username': username}))
            followed = list(db.find('follow', query={'follower_username': username}))

        return Response(
            {
                'followers': [follower['follower_username'] for follower in followers],
                'followed': [followe['followed_username'] for followe in followed]
            },
            status=status.HTTP_200_OK
        )


class FollowUser(APIView):
    permission_classes = [IsAuthenticated]

    def post(request):
        data = request.data

        username = data['username']
        target = data['target']

        with MongoDBHelper(uri=settings.MONGO_URI, database=settings.DB_NAME) as db:
            follow = db.find('follow', query={'follower_username': username, 'followed_username': target})
            
            if follow:
                return Response('ALREADY_FOLLOWED', status=status.HTTP_409_CONFLICT)

            db.insert_one('follow', {
                'follower_username': username,
                'followed_username': target,
            })

        return Response('SUCCESSFULL')

class UnfollowUser(APIView):
    permission_classes = [IsAuthenticated]

    def post(request):
        data = request.data
        username = data['username']
        target = data['target']

        with MongoDBHelper(uri=settings.MONGO_URI, database=settings.DB_NAME) as db:
            follow = db.find('follow', query={'follower_username': username, 'followed_username': target})
            
            if not follow:
                return Response('NOT_FOLLOWED', status=status.HTTP_409_CONFLICT)

            db.delete_one('follow', { # TODO CHECK
                'follower_username': username,
                'followed_username': target,
            })

        return Response('SUCCESSFUL')


class EnrollPath(APIView):
    permission_classes = [IsAuthenticated]

    # requests username and path_id and responses success or fail message, tested
    def post(self, request):
        data = request.data
        username = data['username']
        target = data['path_id']

        with MongoDBHelper(uri=settings.MONGO_URI, database=settings.DB_NAME) as db:
            relation = db.find_one('enroll', {
                'username': username,
                'path_id': target,
            })

            if relation:
                return Response('ALREADY_ENROLLED', status=status.HTTP_409_CONFLICT)

            db.insert_one('enroll', {
                'username': username,
                'path_id': target,
            })
        
        return Response('SUCCESSFUL')


class UnEnrollPath(APIView):
    permission_classes = [IsAuthenticated]

    # requests username and path_id and responses success or fail message, tested
    def post(self, request):
        data = request.data
        username = data['username']
        target = data['path_id']

        with MongoDBHelper(uri=settings.MONGO_URI, database=settings.DB_NAME) as db:
            relation = db.find_one('enroll', {
                'username': username,
                'path_id': target,
            })

            if not relation:
                return Response('NOT_ENROLLED', status=status.HTTP_409_CONFLICT)

            db.delete_one('enroll', {
                'username': username,
                'path_id': target,
            })
        
        return Response('SUCCESSFUL')


class GetEnrolledPaths(APIView):
    permission_classes = [IsAuthenticated]

    # requests username and returns all enrolled paths of the given username, tested
    def post(self, request):
        data = request.data
        username = data['username']

        with MongoDBHelper(uri=settings.MONGO_URI, database=settings.DB_NAME) as db:
            enrolledPaths = list(db.find('enroll', query={'username': username}))

        return Response(
            {
                'enrolledPaths': [path['path_id'] for path in enrolledPaths]
            },
            status=status.HTTP_200_OK
        )