import time
from common.hasher import PBKDF2WrappedSHA1PasswordHasher
from heybooster.helpers.database.mongodb import MongoDBHelper
from django.conf import settings


class User:
    """
        User class
    """

    def __init__(self, **kwargs):
        # Required params
        self.username = kwargs['username']
        self.email = kwargs['email']
        self.password = kwargs['password']
        self.firstname = kwargs['firstname']
        self.lastname = kwargs['lastname']
        # Non-required params
        self.isAdmin = kwargs.get('isAdmin', False)
        self.isBanned = kwargs.get('isBanned', False)
        self.isDeleted = kwargs.get('isDeleted', False)
        self.createdAt = kwargs.get('createdAt', int(time.time()))
        self.updatedAt = kwargs.get('updatedAt', self.createdAt)
        self.lastLogin = kwargs.get('lastLogin')
        self.finishedResourceCount = kwargs.get('finishedResourceCount', 0)
        self.isVerified = kwargs.get('isVerified', False)
        # self.followedResources = kwargs.get('followedResources', [])
        # self.followedResources = kwargs.get('followedResources', [])
        # self.followedResources = kwargs.get('followedResources', [])
        # self.followedResources = kwargs.get('followedResources', [])

        self.bio = kwargs.get('bio', '')
        self.photo = kwargs.get('photo','')

        # ObjectID is not JSON serializable
        if kwargs.get('_id'):
            self._id = kwargs['_id']

    def hash_password(self):
        self.password = PBKDF2WrappedSHA1PasswordHasher().encode(password=self.password, salt=self.createdAt)

    def check_password(self, password):
        return self.password == PBKDF2WrappedSHA1PasswordHasher().encode(password=password, salt=self.createdAt)

    def get_id(self):
        return self._id

    def insert(self):
        with MongoDBHelper(uri=settings.MONGO_URI, database=settings.DB_NAME) as db:
            self._id = db.insert_one('user', self.get_dict(get_password=True)).inserted_id

    def update(self):
        with MongoDBHelper(uri=settings.MONGO_URI, database=settings.DB_NAME) as db:
            db.find_and_modify(collection='user', query={'_id': self._id}, **self.get_dict())

    def get_dict(self, get_id=False, get_password=False):
        result = vars(self)

        if '_id' in result.keys():
            if get_id:
                result['_id'] = str(result['_id'])
            else:
                result.pop('_id')

        if not get_password:
            if result.get('password'):
                result.pop('password')

        return result
