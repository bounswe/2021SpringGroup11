from django.urls import path, include
from django.conf.urls import url
from django.views.decorators.csrf import csrf_exempt
from . import views
#from rest_framework.urlpatterns import format_suffix_patterns

urlpatterns = [
    path('data', views.DCE.as_view(), name='dce'),
    path('', views.Home.as_view(), name='home'),
]

#urlpatterns = format_suffix_patterns(urlpatterns)