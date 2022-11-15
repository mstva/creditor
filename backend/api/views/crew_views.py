from rest_framework import views, status, response

from ..models.crew_model import Crew
from ..serializers.crew_serializer import CrewSerializer


class CrewsAPI(views.APIView):

    def post(self, request): return self.add_crew(request)

    def get(self, request): return self.get_crews_list()

    def patch(self, request, crew_id): return self.update_crew(request, crew_id)

    def put(self, request, crew_id): return self.update_crew(request, crew_id)

    @staticmethod
    def add_crew(request):

        payload = request.data

        crew = Crew(name=payload["name"], image=payload["image"])
        crew.save()

        return response.Response({
            "status": status.HTTP_200_OK,
            "message": "Crew added successfully!",
            "crew": CrewSerializer(crew).data
        })

    @staticmethod
    def get_crews_list():

        crews = Crew.objects.all()

        return response.Response({
            "status": status.HTTP_200_OK,
            "message": f"A list of crews fetched successfully!",
            "crews": CrewSerializer(crews, many=True).data
        })

    @staticmethod
    def update_crew(request, crew_id):

        try:
            crew = Crew.objects.filter(crew_id=crew_id).first()
            if not crew:
                return response.Response({
                    "status": status.HTTP_404_NOT_FOUND,
                    "message": "Crew is not found!"
                })
        except Exception as e:
            print(e)
            return response.Response({
                "status": status.HTTP_400_BAD_REQUEST,
                "message": "Invalid crewId!"
            })

        payload = request.data

        crew.name = payload["name"]
        crew.image = payload["image"]
        crew.save()

        return response.Response({
            "status": status.HTTP_200_OK,
            "message": "Crew updated successfully!",
            "crew": CrewSerializer(crew).data
        })




