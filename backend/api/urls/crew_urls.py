from django.urls import path

from ..views.crew_views import *

urlpatterns = [
    path('', CrewsAPI.as_view()),
    path('<str:crew_id>', CrewsAPI.as_view()),
]
