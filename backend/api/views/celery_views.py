from django.shortcuts import HttpResponse

from ..tasks.add_task import add


def celery_view(request):
    for counter in range(2):
        add.delay(3, counter)
    return HttpResponse("FINISH PAGE LOAD")
