from rest_framework import status
from rest_framework.response import Response
from rest_framework.views import APIView
from authentication.utils import IsAuthenticated
from heybooster.helpers.database.mongodb import MongoDBHelper
from django.conf import settings
from authentication.models import User


class EditUser(APIView):
    """
        Edit User Class
    """

    permission_classes = [IsAuthenticated]

    def post(self, request):
        data = request.data

        with MongoDBHelper(uri=settings.MONGO_URI, database=settings.DB_NAME) as db:
            user = db.find_one('user', query={'email': data['email'], 'username': data['username']})

        if not user:
            return Response({'detail': 'No such user'}, status=status.HTTP_400_BAD_REQUEST)
        
        for key, value in data.items():
            user[key] = value

        user = User(**user)
        user.update()

        return Response({'data': user.get_dict()}, status=status.HTTP_200_OK)
