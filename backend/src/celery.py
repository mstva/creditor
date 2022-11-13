from __future__ import absolute_import
import os
from django.conf import settings
from celery import Celery

os.environ.setdefault('DJANGO_SETTINGS_MODULE', os.environ.get('DJANGO_SETTINGS_MODULE'))

app = Celery(
    broker=os.environ.get('CELERY_RABBITMQ_URL'),
    backend=os.environ.get('CELERY_REDIS_URL'),
)

app.config_from_object('django.conf:settings', namespace='CELERY')
app.autodiscover_tasks(lambda: settings.INSTALLED_APPS)
