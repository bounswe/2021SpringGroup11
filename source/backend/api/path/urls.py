from django.urls import path
from . import views

urlpatterns = [
    path('create-path/', views.CreatePath.as_view(), name='create_path'),
    path('rate-path/', views.RatePath.as_view(), name='rate_path'),
    path('effort-path/', views.EffortPath.as_view(), name='effort_path'),
    path('get-path-detail', views.GetPathDetail.as_view(), name='get_path_detail'),
    path('enroll-path/', views.EnrollPath.as_view(), name='enroll_path'),
    path('unenroll/', views.UnEnrollPath.as_view(), name='unenroll_path'),
    path('search-topic')
]