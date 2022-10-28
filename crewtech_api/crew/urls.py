from django.urls import path
from .views import celery_view, index_view

urlpatterns = [
    path('', index_view),
    path('celerytask/', celery_view),
]
