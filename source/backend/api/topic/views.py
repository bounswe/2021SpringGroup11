from rest_framework import status
from rest_framework.response import Response
from rest_framework.views import APIView
from authentication.utils import IsAuthenticated, IsAdmin
from heybooster.helpers.database.mongodb import MongoDBHelper
from django.conf import settings
from topic.utils import get_topics

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


class SearchTopics(APIView):
    permission_classes = [IsAuthenticated]

    def get(self, request, search_text):
        data = request.data

        username = data['username']

        topics = get_topics(search_text)
        for topic in topics:
            topic['isFav'] = False

        with MongoDBHelper(uri=settings.MONGO_URI, database=settings.DB_NAME) as db:
            fav_topics = list(db.find('favorite', {'username': username, 'ID': {'$in': [topic['id'] for topic in topics]}}))

        for fav_topic in fav_topics:
            for topic in topics:
                if topic['id'] == fav_topic['ID']:
                    topic['isFav'] = True

        return Response(topics)


class MyTopics(APIView):
    permission_classes = [IsAuthenticated]

    def get(self, request):
        data = request.data

        username = data['username']

        with MongoDBHelper(uri=settings.MONGO_URI, database=settings.DB_NAME) as db:
            topics = list(db.find('favorite', {'username': username}))
            topics = [topic['ID'] for topic in topics]
            print(topics)
            topic_data = list(db.find('topic', query={'ID': {'$in': topics}}, projection={'_id': 0, 'name': 1, 'ID': 1, 'description': 1}))

        return Response(topic_data)
