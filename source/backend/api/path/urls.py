from django.urls import path
from . import views

urlpatterns = [
    path('create-path/', views.CreatePath.as_view(), name='create_path'),
    path('rate-path/', views.RatePath.as_view(), name='rate_path'),
    path('effort-path/', views.EffortPath.as_view(), name='effort_path'),
    path('get-path-detail/', views.GetPathDetail.as_view(), name='get_path_detail'),
    path('enroll-path/', views.EnrollPath.as_view(), name='enroll_path'),
    path('unenroll-path/', views.UnEnrollPath.as_view(), name='unenroll_path'),
    path('get-enrolled-paths/', views.GetEnrolledPaths.as_view(), name='get_enrolled_paths'),
    path('finish-path/', views.FinishPath.as_view(), name='finish_path'),
    path('rate-path/', views.RatePath.as_view(), name='rate_path'),
    path('follow-path/', views.FollowPath.as_view(), name='follow_path'),
    path('unfollow-path/', views.UnfollowPath.as_view(), name='unfollow_path'),
    path('get-followed-paths/', views.GetFollowedPaths.as_view(), name='get_followed_paths'),
    path('search-path/<slug:search_text>/', views.SearchPath.as_view(), name='search_path'),

]
