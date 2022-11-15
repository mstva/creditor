from rest_framework import serializers

from ..models.crew_model import Crew


class CrewSerializer(serializers.ModelSerializer):
    class Meta:
        model = Crew
        fields = [
            "crew_id",
            "name",
            "image",
            "created_at",
            "updated_at",
        ]
