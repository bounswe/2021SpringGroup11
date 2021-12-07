from django.urls import path

from . import views

urlpatterns = [
    path('edit-user/', views.EditUser.as_view(), name='edit-user'),
    path('search-user/<slug:search_text>/', views.SearchUser.as_view(), name='search-user'),
    path('ban-user/', views.BanUser.as_view(), name='ban-user'),
    path('get-profile/<slug:username>/', views.GetProfile.as_view(), name='get-profile'),
    path('change-password/', views.ChangePassword.as_view(), name='change-password'),
    #path('get-details/', views.GetDetails.as_view(), name='get-details'),
    path('follow-user/',views.FollowUser.as_view(), name='follow-user'),
    path('unfollow-user', views.UnfollowUser.as_view(), name='unfollow-user'),
    path('get-follow/', views.GetFollow.as_view(), name='get_follow'),
    path('get-ratings/', views.GetRatings.as_view(), name='get_ratings'),
    path('get-enrolls/', views.GetEnrolledPaths.as_view(), name='get_enrolls'),
    path('get-favourite-paths/', views.GetFavouritePaths.as_view(), name='get_favourite_paths')
]
