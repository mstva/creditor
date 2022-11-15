from django.urls import path
from ..views.celery_views import celery_view

urlpatterns = [
    path('celerytask/', celery_view),
]
