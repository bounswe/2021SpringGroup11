from rest_framework import status
from rest_framework.response import Response
from rest_framework.views import APIView
from authentication.utils import IsAuthenticated
from heybooster.helpers.database.mongodb import MongoDBHelper
from django.conf import settings
from topic.utils import get_topics, get_related_topics, topicname
import common.activitystreams as activitystreams

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

            target_name=topicname(target)
            act_id=db.insert_one("activitystreams",
                                 activitystreams.activity_format(summary=f'{username} favorited topic {target_name}.',
                                                                 username=username,
                                                                 obj_id=target,
                                                                 obj_name=target_name,
                                                                 action="Follow")).inserted_id


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


class GetTopic(APIView):
    permission_classes = [IsAuthenticated]

    def get(self, request, topic_id):
        data = request.data

        username = data['username']
        topic_id = int(topic_id)

        with MongoDBHelper(uri=settings.MONGO_URI, database=settings.DB_NAME) as db:
            topic = db.find_one('topic', {'ID': topic_id}, projection={'_id': 0, 'ID': 1, 'name': 1, 'description': 1})
            if not topic:
                return Response({'ID': topic_id, 'name': topicname(topic_id), 'isFav': False})
            favorite = db.find_one('favorite', {'username': username, 'ID': topic_id})
            topic['isFav'] = favorite is not None

        return Response(topic)


class RelatedTopics(APIView):
    permission_classes = [IsAuthenticated]

    def get(self, request, topic_id):
        data = request.data
        username = data['username']
        topic_id = int(topic_id)
        topic_ids = get_related_topics(topic_id)
        topics = []

        for _topic_id in topic_ids:
            name = topicname(_topic_id)
            if name:
                topics.append({'ID': _topic_id, 'name': name, 'isFav': False})
                if len(topics) == 5:
                    break

        with MongoDBHelper(uri=settings.MONGO_URI, database=settings.DB_NAME) as db:
            fav_topics = list(db.find('favorite', {'username': username, 'ID': {'$in': [topic['ID'] for topic in topics]}}))

        for fav_topic in fav_topics:
            for topic in topics:
                if topic['ID'] == fav_topic['ID']:
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
