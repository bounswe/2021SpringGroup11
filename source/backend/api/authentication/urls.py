from django.urls import path
from . import views

urlpatterns = [
    path('signup/', views.SignUp.as_view(), name='signup'),
    path('login/', views.LogIn.as_view(), name='login'),
    path('refresh-token/', views.RefreshToken.as_view(), name='refresh-token'),
    path('ban-user/', views.BanUser.as_view(), name='ban-user')
]
