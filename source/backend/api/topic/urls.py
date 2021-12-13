from django.urls import path
from . import views


urlpatterns = [
    path('unfavorite-topic/', views.UnFavoriteTopic.as_view(), name='unfavorite_topic'),
    path('favorite-topic/', views.FavoriteTopic.as_view(), name='favorite_topic'),
    path('search-topic/<slug:search_text>/', views.SearchTopics.as_view(), name='search_topics'),
    path('get-topic/<slug:topic_id>/', views.GetTopic.as_view(), name='get_topic'),
    path('related-topic/<slug:topic_id>/', views.RelatedTopics.as_view(), name='related_topics'),
]