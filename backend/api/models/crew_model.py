from uuid import uuid4
from django.db import models


class Crew(models.Model):
    class Meta:
        db_table = "api_crews"

    crew_id = models.UUIDField(primary_key=True, default=uuid4)

    name = models.CharField(max_length=255, blank=True)
    image = models.FileField(upload_to="crews/", null=True)

    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True, null=True)


