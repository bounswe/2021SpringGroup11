from django.urls import path

from . import views

urlpatterns = [
    path('edit-user/', views.EditUser.as_view(), name='edit_user'),
    path('search-user/<slug:search_text>/', views.SearchUser.as_view(), name='search_user'),
    path('ban-user/', views.BanUser.as_view(), name='ban_user'),
    path('get-profile/<slug:username>/', views.GetProfile.as_view(), name='get_profile'),
    path('change-password/', views.ChangePassword.as_view(), name='change_password'),
    path('follow-user/',views.FollowUser.as_view(), name='follow_user'),
    path('unfollow-user/', views.UnfollowUser.as_view(), name='unfollow_user'),
    path('get-follow/', views.GetFollow.as_view(), name='get_follow'),
    path('get-ratings/', views.GetRatings.as_view(), name='get_ratings'),
    path('get-enrolls/', views.GetEnrolledPaths.as_view(), name='get_enrolls'),
    path('get-favourite-paths/', views.GetFavouritePaths.as_view(), name='get_favourite_paths'),
    path('wordcloud/', views.Wordcloud.as_view(), name='wordcloud_user'),
]
