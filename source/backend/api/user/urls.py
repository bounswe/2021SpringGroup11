from django.urls import path

from . import views

urlpatterns = [
    path('edit-user/', views.EditUser.as_view(), name='edit-user')
]
