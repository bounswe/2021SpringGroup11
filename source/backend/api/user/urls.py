from django.urls import path

from . import views

urlpatterns = [
    path('edit-user/', views.EditUser.as_view(), name='edit-user'),
    path('delete-user/', views.DeleteUser.as_view(), name='delete-user'),
    path('search-user/<slug:search_text>/', views.SearchUser.as_view(), name='search-user'),
    path('ban-user/', views.BanUser.as_view(), name='ban-user'),
    path('get-profile/<slug:username>/', views.GetProfile.as_view(), name='get-profile'),
    path('change-password/', views.ChangePassword.as_view(), name='change-password')
]
