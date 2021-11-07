from django.urls import path

from . import views

urlpatterns = [
    path('edit-user/', views.EditUser.as_view(), name='edit-user'),
    path('search-user/<slug:search_text>', views.SearchUser.as_view(), name='search-user')
]
