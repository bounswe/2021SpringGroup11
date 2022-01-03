import time
import base64
import operator
from rest_framework import status
from rest_framework.response import Response
from rest_framework.views import APIView
from authentication.utils import IsAuthenticated
from heybooster.helpers.database.mongodb import MongoDBHelper
from django.conf import settings
from common.wordcloudgen import wordcloudgen
from common.topicname import topicname
import common.activitystreams as activitystreams
from path.utils import get_related_topics, get_rate_n_effort, path_is_enrolled, path_is_followed
from bson.objectid import ObjectId

class CreatePath(APIView):
    permission_classes = [IsAuthenticated]
    
    def post(self, request):
        data = request.data

        title = data['title']
        description = data['description']
        topics = data['topics']
        creator_username = data['username']
        creator_email = data['email']
        created_at = int(time.time())
        photo = data['photo']
        milestones = data['milestones']
        is_banned = False
        is_deleted = False

        with MongoDBHelper(uri=settings.MONGO_URI, database=settings.DB_NAME) as db:
            topic_ids = []
            milestone_ids = []

            for topic in topics:
                if not db.find_one('topic', {'ID': topic['ID']}):
                    db.insert_one('topic', {
                        'ID': topic['ID'],
                        'name': topic['name'],
                        'description': topic['description']
                    })
                
                topic_ids.append(topic['ID'])

            for milestone in milestones:
                id = db.insert_one('milestone', {
                    'title': milestone['title'],
                    'body': milestone['body'],
                    'type': milestone['type']
                }).inserted_id

                milestone_ids.append(str(id))


            id = db.insert_one('path',
            {
                'title': title,
                'description': description,
                'topics': topic_ids,
                'creator_username': creator_username,
                'creator_email': creator_email,
                'created_at': created_at,
                'photo': photo,
                'milestones': milestone_ids,
                'is_banned': is_banned,
                'is_deleted': is_deleted
            }).inserted_id

            act_id=db.insert_one("activitystreams",activitystreams.activity_format(summary=f'{creator_username} created a new path named {title}.', username=creator_username, obj_id=str(id), obj_name=title)).inserted_id

        return Response({'pathID': str(id)}, status=status.HTTP_200_OK)

class FinishMilestone(APIView):
    permission_classes = [IsAuthenticated]

    def post(self, request):
        data = request.data
        username = data['username']
        milestone_id = data['milestone_id']

        with MongoDBHelper(uri=settings.MONGO_URI, database=settings.DB_NAME) as db:
            db.insert_one('finished_milestone', {
                'username': username,
                'milestone_id': milestone_id
            })

            milestone=db.find_one('milestone',query={"_id":ObjectId(milestone_id)})

            act_id=db.insert_one("activitystreams",
                                 activitystreams.activity_format(
                                     summary=f'{username} finished the milestone {milestone["title"]}.',
                                     username=username,
                                     obj_id=path_id,
                                     obj_name=path["title"],
                                     action="Create")).inserted_id

        
        return Response('SUCCESSFUL')

class UnfinishMilestone(APIView):
    permission_classes = [IsAuthenticated]
    
    def post(self, request):
        data = request.data
        username = data['username']
        milestone_id = data['milestone_id']
        
        with MongoDBHelper(uri=settings.MONGO_URI, database=settings.DB_NAME) as db:
            db.delete_one('finished_milestone', {
                'username': username,
                'milestone_id': milestone_id
            })
        
        return Response('SUCCESSFUL')

class RatePath(APIView):
    permission_classes = [IsAuthenticated]

    def post(self, request):
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
        
        return Response('SUCCESSFUL')

class EffortPath(APIView): #this endpoint is tested
    permission_classes = [IsAuthenticated]

    def post(self, request):
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
    
        return Response('SUCCESSFUL')

class GetPathDetail(APIView):
    permission_classes = [IsAuthenticated]

    def post(self, request):
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

    def post(self, request):
        data = request.data

        search = data['search']

        with MongoDBHelper(uri=settings.MONGO_URI, database=settings.DB_NAME) as db:
            topics = db.find('')# full text + regex search
        
        return Response(list(topics), status=status.HTTP_200_OK)

class GetFollow(APIView):
    permission_classes = [IsAuthenticated]
    
    def get(self, request):
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

    def post(self, request):
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

    def post(self, request):
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

    """ requests username and path_id and responses success or fail message, tested"""
    def post(self, request):
        data = request.data
        username = data['username']
        target = data['path_id']

        with MongoDBHelper(uri=settings.MONGO_URI, database=settings.DB_NAME) as db:
            path = db.find_one('path', query={'_id': ObjectId(target)})

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
            act_id=db.insert_one("activitystreams",
                                 activitystreams.activity_format(summary=f'{username} enrolled the path {path["title"]}.',
                                                                 username=username,
                                                                 obj_id=target,
                                                                 obj_name=path["title"],
                                                                 action="Join")).inserted_id



        
        return Response('SUCCESSFUL')


class UnEnrollPath(APIView):
    permission_classes = [IsAuthenticated]

    """ requests username and path_id and responses success or fail message, tested"""
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
    # permission_classes = [IsAuthenticated]

    """ requests username and returns all enrolled paths of the given username, tested """
    def post(self, request):
        data = request.data
        username = data['username']

        with MongoDBHelper(uri=settings.MONGO_URI, database=settings.DB_NAME) as db:
            enrolledPaths = list(db.find('enroll', query={'username': username},  projection={'_id': 0}))
            allPaths = list(
                db.find('path', query={'_id': {'$in': [ObjectId(path['path_id']) for path in enrolledPaths]}},
                projection={
                    '_id': 1,
                    'title': 1,
                    'photo': 1
                }))

        for path in allPaths:
            path['_id'] = str(path['_id'])
            rating, effort = get_rate_n_effort(path['_id'])
            path['rating'] = rating
            path['effort'] = effort
            path['isFollowed'] = path_is_followed(path['_id'], username)

        return Response(
            allPaths,
            status=status.HTTP_200_OK
        )

class FinishPath(APIView): #Caution: this endpoint marks the whole path as finished, not a single milestone
    permission_classes = [IsAuthenticated]

    def post(self, request):
        data = request.data

        username = data['username']
        path_id = data['path_id']

        with MongoDBHelper(uri=settings.MONGO_URI, database=settings.DB_NAME) as db:
            path = db.find_one('path', query={'_id': ObjectId(path_id)})

            db.insert_one('pathFinished',
                          {
                              'username': username,
                              'path_id': path_id,
                          })

            relation = db.find_one('enroll', {
                'username': username,
                'path_id': path_id,
            })

            if not relation:
                return Response('NOT_ENROLLED', status=status.HTTP_409_CONFLICT)

            db.delete_one('enroll', {
                'username': username,
                'path_id': path_id,
            })

            act_id=db.insert_one("activitystreams",
                                 activitystreams.activity_format(
                                     summary=f'{username} finished the path {path["title"]}.',
                                     username=username,
                                     obj_id=path_id,
                                     obj_name=path["title"],
                                     action="Create")).inserted_id

        return Response('SUCCESSFUL')

class GetFinishedPaths(APIView):
    # permission_classes = [IsAuthenticated]

    """ requests username and returns all enrolled paths of the given username, tested """
    def post(self, request):
        data = request.data
        username = data['username']

        with MongoDBHelper(uri=settings.MONGO_URI, database=settings.DB_NAME) as db:
            finishedPaths = list(db.find('pathFinished', query={'username': username},  projection={'_id': 0}))
            allPaths = list(
                db.find('path', query={'_id': {'$in': [ObjectId(path['path_id']) for path in finishedPaths]}},
                projection={
                    '_id': 1,
                    'title': 1,
                    'photo': 1
                }))

        for path in allPaths:
            path['_id'] = str(path['_id'])
            rating, effort = get_rate_n_effort(path['_id'])
            path['rating'] = rating
            path['effort'] = effort
            path['isFollowed'] = path_is_followed(path['_id'], username)

        return Response(
            allPaths,
            status=status.HTTP_200_OK
        )

class Wordcloud(APIView):
    permission_classes = [IsAuthenticated]

    def post(self, request):
        data=request.data

        path_id=data['path_id']
        try:
            width=data['width']
        except:
            width=600
        try:
            height=data['height']
        except:
            height=400

        with MongoDBHelper(uri=settings.MONGO_URI, database=settings.DB_NAME) as db:
            path = db.find_one('path', query={'_id': ObjectId(path_id)})

        if not path:
            return Response('PATH_NOT_FOUND', status=status.HTTP_404_NOT_FOUND)

        text=""
        text+=path["description"]+"\n"
        text+=path["description"]+"\n" #intentionally added twice to make it more important
        for m in path["milestones"]:
            if type(m) == str:
                continue
            text+=m["title"]+"\n"
            text+=m["title"]+"\n" # included twice to emphasize
            text+=m["body"]+"\n"

        topics=path["topics"]
        topicnames=[topicname(t) for t in topics]

        res=wordcloudgen(text,topicnames,width=width,height=height)
        res=base64.b64encode(res)
        #res="data:image/png;base64"+res.decode()
        res=res.decode()
        return Response(res,status=status.HTTP_200_OK)

class GetPath(APIView):
    permission_classes = [IsAuthenticated]

    def get(self, request, path_id):
        data = request.data
        username = data['username']

        with MongoDBHelper(uri=settings.MONGO_URI, database=settings.DB_NAME) as db:
            path = db.find_one('path', query={'_id': ObjectId(path_id)})
            follow = db.find_one('follow_path', query={'username': username, 'path_id': path_id})
            enroll = db.find_one('enroll', query={'username': username, 'path_id': path_id})
            topics = list(db.find('topic', query={'ID': {'$in': path['topics']}}))
            milestones = list(db.find('milestone', query={'_id': {'$in': [ObjectId(milestone_id) for milestone_id in path['milestones']]}}))
            #finished_milestones = list(db.find('finished_milestone', query={'username': username, '_id': {'$in': [ObjectId(milestone_id) for milestone_id in path['milestones']]}}))
            finished_milestones = list(db.find('finished_milestone', query={'username': username, 'milestone_id': {'$in': path['milestones']}}))

        path['_id'] = str(path['_id'])
        path['isFollowed'] = follow is not None
        path['isEnrolled'] = enroll is not None
        rating, effort = get_rate_n_effort(path['_id'])
        path['rating'] = rating
        path['effort'] = effort

        new_path_topics = []
        for path_topic in path['topics']:
            for topic in topics:
                if path_topic == topic['ID']:
                    path_topic = {}
                    path_topic['ID'] = topic['ID']
                    path_topic['name'] = topic['name']
                    path_topic['description'] = topic['description']
                    new_path_topics.append(path_topic)
                    break
        path['topics'] = new_path_topics

        finished_milestone_ids = [finished_milestone['milestone_id'] for finished_milestone in finished_milestones]

        new_path_milestones = []
        for path_milestone in path['milestones']:
            for milestone in milestones:
                if str(milestone['_id']) == path_milestone:
                    path_milestone = {}
                    path_milestone['_id'] = str(milestone['_id'])
                    path_milestone['title'] = milestone['title']
                    path_milestone['body'] = milestone['body']
                    path_milestone['isFinished'] = str(milestone['_id']) in finished_milestone_ids
                    new_path_milestones.append(path_milestone)
                    break
        path['milestones'] = new_path_milestones

        return Response(path)


class GetRelatedPath(APIView):
    permission_classes = [IsAuthenticated]

    def get(self, request, topic_id):
        data = request.data
        username = data['username']

        topics = get_related_topics(topic_id)
        
        with MongoDBHelper(uri=settings.MONGO_URI, database=settings.DB_NAME) as db:
            paths = list(db.find('path', query={'topic': {'$not': {'$elemMatch': {'$nin': topics}}}})) # check
            # 'topics.0': {$exists: true}
            followedPaths = list(db.find('follow_path', query={'username': username}, projection={'_id': 0}))
            enrolledPaths = list(db.find('enroll', query={'username': username},  projection={'_id': 0}))

        for path in paths:
            path['_id'] = str(path['_id'])
            path['isFollowed'] = False
            path['isEnrolled'] = False
            rating, effort = get_rate_n_effort(path['_id'])
            path['rating'] = rating
            path['effort'] = effort

        for followed_path in followedPaths:
            for path in paths:
                if path['_id'] == followed_path['path_id']:
                    path['isFollowed'] = True

        for enrolled_path in enrolledPaths:
            for path in paths:
                if path['_id'] == enrolled_path['path_id']:
                    path['isEnrolled'] = True

        return Response(paths, status=status.HTTP_200_OK)

class FollowPath(APIView):
    permission_classes = [IsAuthenticated]

    """ requests username and path_id and responses success or fail message, tested"""
    def post(self, request):
        data = request.data
        username = data['username']
        target = data['path_id']

        with MongoDBHelper(uri=settings.MONGO_URI, database=settings.DB_NAME) as db:
            path = db.find_one('path', query={'_id': ObjectId(target)})

            relation = db.find_one('follow_path', {
                'username': username,
                'path_id': target,
            })

            if relation:
                return Response('ALREADY_FOLLOWED', status=status.HTTP_409_CONFLICT)

            db.insert_one('follow_path', {
                'username': username,
                'path_id': target,
            })


            act_id=db.insert_one("activitystreams",
                                 activitystreams.activity_format(
                                     summary=f'{username} started following the path {path["title"]}.',
                                     username=username,
                                     obj_id=target,
                                     obj_name=path["title"],
                                     action="Follow")).inserted_id


        return Response('SUCCESSFUL')


class UnfollowPath(APIView):
    permission_classes = [IsAuthenticated]

    """ requests username and path_id and responses success or fail message, tested"""
    def post(self, request):
        data = request.data
        username = data['username']
        target = data['path_id']

        with MongoDBHelper(uri=settings.MONGO_URI, database=settings.DB_NAME) as db:
            relation = db.find_one('follow_path', {
                'username': username,
                'path_id': target,
            })

            if not relation:
                return Response('NOT_FOLLOWED', status=status.HTTP_409_CONFLICT)

            db.delete_one('follow_path', {
                'username': username,
                'path_id': target,
            })

        return Response('SUCCESSFUL')


class GetFollowedPaths(APIView):
    # permission_classes = [IsAuthenticated]

    """ requests username and returns all followed paths of the given username, tested """
    def post(self, request):
        data = request.data
        username = data['username']

        with MongoDBHelper(uri=settings.MONGO_URI, database=settings.DB_NAME) as db:
            followedPaths = list(db.find('follow_path', query={'username': username}, projection={'_id': 0}))
            allPaths = list(db.find('path',
                query={'_id': {'$in': [ObjectId(path['path_id']) for path in followedPaths]}},
                projection={
                    '_id': 1,
                    'title': 1,
                    'photo': 1
                }
            ))

        for path in allPaths:
            path['_id'] = str(path['_id'])
            rating, effort = get_rate_n_effort(path['_id'])
            path['rating'] = rating
            path['effort'] = effort
            path['isEnrolled'] = path_is_enrolled(path['_id'], username)

        return Response(
            allPaths,
            status=status.HTTP_200_OK
        )


class SearchPath(APIView):
    # permission_classes = [IsAuthenticated]

    def get(self, request, search_text):
        data = request.data
        username = data['username']
                
        with MongoDBHelper(uri=settings.MONGO_URI, database=settings.DB_NAME) as db:
            paths = list(db.find(
                'path',  # TODO Create fulltext index on subtexts
                query={'$or': [{'$text': {'$search': search_text}},
                               {'title': {'$regex': search_text, '$options': 'i'}}]},
                projection={}
            ).limit(10))

            followedPaths = list(db.find('follow_path', query={'username': username}, projection={'_id': 0}))
            enrolledPaths = list(db.find('enroll', query={'username': username},  projection={'_id': 0}))

        for path in paths:
            path['_id'] = str(path['_id'])
            path['isFollowed'] = False
            path['isEnrolled'] = False
            rating, effort = get_rate_n_effort(path['_id'])
            path['rating'] = rating
            path['effort'] = effort

        for followed_path in followedPaths:
            for path in paths:
                if path['_id'] == followed_path['path_id']:
                    path['isFollowed'] = True

        for enrolled_path in enrolledPaths:
            for path in paths:
                if path['_id'] == enrolled_path['path_id']:
                    path['isEnrolled'] = True

        return Response(paths, status=status.HTTP_200_OK)


class EditPath(APIView):
    permission_classes = [IsAuthenticated]

    def post(self, request):
        data = request.data

        path_id = data['pathID']
        title = data['title']
        description = data['description']
        topics = data['topics']
        photo = data['photo']
        milestones = data['milestones']

        with MongoDBHelper(uri=settings.MONGO_URI, database=settings.DB_NAME) as db:
            topic_ids = []
            milestone_ids = []

            for topic in topics:
                if not db.find_one('topic', {'ID': topic['ID']}):
                    db.insert_one('topic', {
                        'ID': topic['ID'],
                        'name': topic['name'],
                        'description': topic['description']
                    })
                
                topic_ids.append(topic['ID'])

            for milestone in milestones:
                if not milestone.get('ID'):
                    id = db.insert_one('milestone', {
                        'title': milestone['title'],
                        'body': milestone['body']
                    }).inserted_id
                    milestone_ids.append(str(id))
                else:
                    milestone_ids.append(str(milestone['ID']))

            db.find_and_modify(
                'path',
                query={
                    '_id': ObjectId(path_id)
                },
                title=title,
                description=description,
                topics=topic_ids,
                photo=photo,
                milestones=milestone_ids,   
            )

        return Response('SUCCESS')

class MyPaths(APIView):
    permission_classes = [IsAuthenticated]

    def get(self, request):
        data = request.data
        username = data['username']

        with MongoDBHelper(uri=settings.MONGO_URI, database=settings.DB_NAME) as db:
            paths = list(db.find('path', query={'creator_username': username}))

        for path in paths:
            path['_id'] = str(path['_id'])
            rating, effort = get_rate_n_effort(path['_id'])
            path['rating'] = rating
            path['effort'] = effort

        return Response(paths)

class FinishTask(APIView):
    permission_classes = [IsAuthenticated]

    def post(self, request):
        data = request.data
        username = data['username']
        milestone_id = data['milestone_id']

        with MongoDBHelper(uri=settings.MONGO_URI, database=settings.DB_NAME) as db:
            db.insert_one('finished_milestone', {
                'username': username,
                'milestone_id': milestone_id
            })

        return Response('SUCCESSFUL')

class UnfinishTask(APIView):
    permission_classes = [IsAuthenticated]

    def post(self, request):
        data = request.data
        username = data['username']
        milestone_id = data['milestone_id']

        with MongoDBHelper(uri=settings.MONGO_URI, database=settings.DB_NAME) as db:
            db.delete_one('finished_milestone', {
                'username': username,
                'milestone_id': milestone_id
            })

        return Response('SUCCESSFUL')

class AddResource(APIView):
    permission_classes = [IsAuthenticated]

    def post(self, request):
        data = request.data

        path_id = data['path_id']
        username = data['username']
        order = data['order']
        link = data['link']
        description = data['description']
        created_at = int(time.time())

        with MongoDBHelper(uri=settings.MONGO_URI, database=settings.DB_NAME) as db:
            db.update(
                'path',
                {'_id': ObjectId(path_id)},
                { '$push': {'resources': {
                            'username': username,
                            'order': order,
                            'link': link,
                            'description': description,
                            'created_at': created_at
                        }
                    }
                }
            )

        return Response('SUCCESSFUL')

class GetPopular(APIView):
    permission_classes = [IsAuthenticated]

    def get(self, request):
        # Algorithm 1 Using Activity Streams
        data = request.data

        username = data['username']

        with MongoDBHelper(uri=settings.MONGO_URI, database=settings.DB_NAME) as db:
            streams = db.find('activitystreams', query={}).limit(500)

            topic_dict = {}
            path_dict = {}
            topic_ids = []
            path_ids = []

            for stream in streams:
                id = stream['object']['id']

                if type(id) == int:
                    if id in topic_dict.keys():
                        topic_dict[id] += 1
                    else:
                        topic_dict[id] = 1
                else:
                    if id in path_dict.keys():
                        path_dict[id] += 1
                    else:
                        path_dict[id] = 1

            topic_dict = dict(sorted(  topic_dict.items(),
                            key=operator.itemgetter(1),
                            reverse=True))
            path_dict = dict(sorted(  path_dict.items(),
                            key=operator.itemgetter(1),
                            reverse=True))
            
            for key, value in topic_dict.items():
                topic_ids.append(key)
                if len(topic_ids) >= 5:
                    break
            
            for key, value in path_dict.items():
                path_ids.append(ObjectId(key))
                if len(path_ids) >= 5:
                    break
            
            topics = db.find('topic', query={'ID': {'$in': topic_ids}})
            paths = db.find('path', query={'_id': {'$in': path_ids}})

            topics = list(topics)
            paths = list(paths)

            fav_topics = list(db.find('favorite', {'username': username, 'ID': {'$in': [topic['ID'] for topic in topics]}}))
            
            for topic in topics:
                topic['_id'] = str(topic['_id'])
                topic['isFav'] = False

            for fav_topic in fav_topics:
                for topic in topics:
                    if topic['ID'] == fav_topic['ID']:
                        topic['isFav'] = True

            for path in paths:
                path['_id'] = str(path['_id'])
                rating, effort = get_rate_n_effort(path['_id'], db)
                path['rating'] = rating
                path['effort'] = effort
                path['isEnrolled'] = path_is_enrolled(path['_id'], username, db)
                path['isFollowed'] = path_is_followed(path['_id'], username, db)

        return Response({'topics': topics, 'paths': paths})

class GetNew(APIView):
    permission_classes = [IsAuthenticated]

    def get(self, request):
        data = request.data

        username = data['username']

        with MongoDBHelper(uri=settings.MONGO_URI, database=settings.DB_NAME) as db:
            topics = list(db.find('topic', query={}).limit(5))
            paths = list(db.find('path', query={}).limit(5))

            fav_topics = list(db.find('favorite', {'username': username, 'ID': {'$in': [topic['ID'] for topic in topics]}}))
            
            for topic in topics:
                topic['_id'] = str(topic['_id'])
                topic['isFav'] = False

            for fav_topic in fav_topics:
                for topic in topics:
                    if topic['ID'] == fav_topic['ID']:
                        topic['isFav'] = True

            for path in paths:
                path['_id'] = str(path['_id'])
                rating, effort = get_rate_n_effort(path['_id'], db)
                path['rating'] = rating
                path['effort'] = effort
                path['isEnrolled'] = path_is_enrolled(path['_id'], username, db)
                path['isFollowed'] = path_is_followed(path['_id'], username, db)

        return Response({'topics': topics, 'paths': paths})

class GetForYou(APIView):
    permission_classes = [IsAuthenticated]

    def get(self, request):
        data = request.data

        username = data['username']

        with MongoDBHelper(uri=settings.MONGO_URI, database=settings.DB_NAME) as db:
            followed_users = list(db.find('follow', query={'follower_username': username}))
            followed_users = [f['followed_username'] for f in followed_users]

            topics = list(db.find('favorite', query={'username': {'$in': followed_users}}).limit(5))
            paths = list(db.find('path', query={'creator_username': {'$in': followed_users}}).limit(5))

            streams = db.find('activitystreams', query={}).limit(100)

            topic_ids = []
            path_ids = []

            for stream in streams:
                id = stream['object']['id']

                if type(id) == int:
                    if id not in topic_ids:
                        topic_ids.append(id)
                else:
                    if id not in path_ids:
                        path_ids.append(id)

            used_topic_ids = [topic['ID'] for topic in topics]
            used_path_ids = [str(path['_id']) for path in paths]

            for topic_id in topic_ids:
                if len(topics) >= 5:
                    break
                if topic_id in used_topic_ids:
                    continue
                used_topic_ids.append(topic_id)
                data = db.find_one('topic', query={'ID': topic_id})
                if data:
                    topics.append(data)

            for path_id in path_ids:
                if len(paths) >= 5:
                    break
                if path_id in used_path_ids:
                    continue
                used_path_ids.append(path_id)
                data = db.find_one('path', query={'_id': ObjectId(path_id)})
                if data:
                    paths.append(data)

            fav_topics = list(db.find('favorite', {'username': username, 'ID': {'$in': [topic['ID'] for topic in topics]}}))
            
            for topic in topics:
                topic['_id'] = str(topic['_id'])
                topic['isFav'] = False

            for fav_topic in fav_topics:
                for topic in topics:
                    if topic['ID'] == fav_topic['ID']:
                        topic['isFav'] = True

            for path in paths:
                path['_id'] = str(path['_id'])
                rating, effort = get_rate_n_effort(path['_id'], db)
                path['rating'] = rating
                path['effort'] = effort
                path['isEnrolled'] = path_is_enrolled(path['_id'], username, db)
                path['isFollowed'] = path_is_followed(path['_id'], username, db)

        return Response({'topics': topics, 'paths': paths})
