from django.urls import path

from . import views

urlpatterns = [
    path('create-path/', views.CreatePath, name='create_path'),
    path('rate-path/', views.RatePath, name='rate_path'),
    path('effort-path/', views.EffortPath, name='effort_path'),
    path('get-path-detail', views.GetPathDetail, name='get_path_detail'),
    path('search-topic')
]
