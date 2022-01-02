from django.urls import path
from . import views

urlpatterns = [
    path('create-path/', views.CreatePath.as_view(), name='create_path'),
    path('get-path/<slug:path_id>/', views.GetPath.as_view(), name='get_path'),
    path('my-paths/', views.MyPaths.as_view(), name='my_paths'),
    path('edit-path/', views.EditPath.as_view() , name='edit_path'),
    path('rate-path/', views.RatePath.as_view(), name='rate_path'),
    path('effort-path/', views.EffortPath.as_view(), name='effort_path'),
    path('follow-path/', views.FollowPath.as_view(), name='follow_path'),
    path('unfollow-path/', views.UnfollowPath.as_view(), name='unfollow_path'),
    path('get-followed-paths/', views.GetFollowedPaths.as_view(), name='get_followed_paths'),
    path('enroll-path/', views.EnrollPath.as_view(), name='enroll_path'),
    path('unenroll-path/', views.UnEnrollPath.as_view(), name='unenroll_path'),
    path('get-enrolled-paths/', views.GetEnrolledPaths.as_view(), name='get_enrolled_paths'),
    path('related-path/<slug:topic_id>/', views.GetRelatedPath.as_view(), name='get_related_path'),
    path('search-path/<slug:search_text>/', views.SearchPath.as_view(), name='search_path'),
    path('finish-path/', views.FinishPath.as_view(), name='finish_path'),
    path('finish-milestone/', views.FinishMilestone.as_view(), name='finish_milestone'),
    path('unfinish-milestone/', views.UnfinishMilestone.as_view(), name='unfinish_milestone'),
    path('finish-task/', views.FinishTask.as_view(), name='finish_task'),
    path('unfinish-task/', views.UnfinishTask.as_view(), name='unfinish_task'),
    path('wordcloud/', views.Wordcloud.as_view(), name='wordcloud_path'),
]
