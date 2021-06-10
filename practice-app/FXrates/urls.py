from django.urls import path

from . import views

urlpatterns=[
    path('api/<str:pair>/<str:freq>/<int:begin>/<int:till>.json',views.api,name='api'),
    path('index.html',views.index,name='index'),
    path('postcomment.html',views.postcomment,name='postcomment'),
    path('getcomments.html',views.getcomments,name='getcomments'),
]
