from django.urls import path

from . import views

urlpatterns = [
    path('edit-user/', views.EditUser.as_view(), name='edit-user'),
    path('search-user/<slug:search_text>/', views.SearchUser.as_view(), name='search-user'),
    path('ban-user/', views.BanUser.as_view(), name='ban-user'),
    path('get-profile/<slug:username>/', views.GetProfile.as_view(), name='get-profile'),
    path('change-password/', views.ChangePassword.as_view(), name='change-password'),
    path('get-details/', views.GetDetails.as_view(), name='get-details'),
    path('follow-user/',views.FollowUser, name='follow-user'),
    path('unfollow-user', views.UnfollowUser, name='unfollow-user')
    #path('get-followers/',,name=),
    #path('get-efforts/',,),
    #path('get-ratings/',,)
]
