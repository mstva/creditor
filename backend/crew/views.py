import os
from django.shortcuts import HttpResponse

from .tasks import add


def index_view(request):
    return HttpResponse(f"<h1>Hello World {os.environ.get('DJANGO_SETTINGS_MODULE')}</h1>")


def celery_view(request):
    for counter in range(2):
        add.delay(3, counter)
    return HttpResponse("FINISH PAGE LOAD")
