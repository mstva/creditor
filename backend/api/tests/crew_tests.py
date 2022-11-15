import pytest
from ..models.crew_model import Crew


@pytest.mark.django_db
def test_crew():
    crew_one = Crew.objects.create(name="crew one")
    assert crew_one.name == "crew one"
