from .base import *
import os

DEBUG = True

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': os.environ.get("POSTGRES_DB"),
        'USER': os.environ.get("POSTGRES_USER"),
        'PASSWORD': os.environ.get("POSTGRES_PASSWORD"),
        'HOST': os.environ.get("POSTGRES_HOST"),
        'PORT': os.environ.get("POSTGRES_PORT"),
    }
}

AWS_ACCESS_KEY_ID = os.environ.get('SPACE_ACCESS_KEY')
AWS_SECRET_ACCESS_KEY = os.environ.get('SPACE_SECRET_KEY')
AWS_STORAGE_BUCKET_NAME = os.environ.get('SPACE_NAME')
AWS_S3_ENDPOINT_URL = os.environ.get('SPACE_ENDPOINT_URL')
AWS_S3_LOCATION_URL = os.environ.get('SPACE_LOCATION_URL')
AWS_S3_OBJECT_PARAMETERS = {'CacheControl': 'max-age=86400'}

STATIC_URL = f'{AWS_S3_LOCATION_URL}/static/'
STATICFILES_STORAGE = 'src.storage.StaticStorage'

MEDIA_URL = f'{AWS_S3_LOCATION_URL}/media/'
DEFAULT_FILE_STORAGE = 'src.storage.MediaStorage'
