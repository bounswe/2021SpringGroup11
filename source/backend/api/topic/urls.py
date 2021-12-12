from django.urls import path
from . import views


urlpatterns = [
    path('unfavorite-topic/', views.UnFavoriteTopic.as_view(), name='unfavorite_topic'),
    path('favorite-topic/', views.FavoriteTopic.as_view(), name='favorite_topic'),
    path('search-topic/<slug:search_text>/', views.SearchTopics.as_view(), name='search_topics'),
]