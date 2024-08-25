from django.shortcuts import render
from .AIEngine.diseases_Filter import assess_recipes
from rest_framework.decorators import api_view
from rest_framework.response import Response
from .AIEngine.suggest_recipes import RecipeSuggester
from django.http import JsonResponse
from django.contrib.auth import authenticate, login
from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework import status
from .serializer import UserSerializer, UserProfileSerializer
from rest_framework.authtoken.models import Token
from django.contrib.auth.models import User
from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import IsAuthenticated
from .AIEngine.Genetic_algorithm import run_genetic_algorithm


recipe_suggester = RecipeSuggester(
    r'C:\Users\hp\Recipies\Data\The Final Dataset with image url.csv')


@api_view(['POST'])
@permission_classes([IsAuthenticated])
def recipes_information(request):
    if request.method == 'POST':
        name = request.data['name']
        matching_recipe = recipe_suggester.get_meal_details_by_name(name)

        if matching_recipe:
            return JsonResponse({"recipes": matching_recipe}, status=200, safe=False)
        else:
            return JsonResponse({"error": f"No meal found with the name '{name}'"}, status=404)


@api_view(['POST'])
@permission_classes([IsAuthenticated])
def filter_recipes_view(request):
    if request.method == 'POST':
        recipes = request.data["recipes"]
        filter_criteria = request.data["Filter"]
        filtered_df = recipe_suggester.filter_recipes(recipes, filter_criteria)
        results = assess_recipes(filtered_df)

        return JsonResponse({"recipes": results}, status=200, safe=False)


@api_view(['GET'])
@permission_classes([IsAuthenticated])
def recommeded_based_rate(request):
    if request.method == 'GET':
        matching_recipes = recipe_suggester.recommend_top_rated_recipes()
        return JsonResponse({"recipes": matching_recipes}, status=200, safe=False)


@api_view(['GET'])
@permission_classes([IsAuthenticated])
def recommend_similar_recipes_by_ingredients(request):
    if request.method == 'GET':
        user = request.user
        selected_dishes = user.behavior
        data = recipe_suggester.df
        return JsonResponse({"recipes": selected_dishes}, status=200, safe=False)


@api_view(['POST'])
def user_signup(request):
    serializer = UserSerializer(data=request.data)
    if serializer.is_valid():
        user = serializer.save()
        token, created = Token.objects.get_or_create(user=user)
        return Response({
            'user': serializer.data,
            'token': token.key
        }, status=status.HTTP_201_CREATED)
    else:
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


@api_view(['POST'])
def login_view(request):
    email = request.data.get('email')
    password = request.data.get('password')
    try:
        user = User.objects.get(email=email)
    except User.DoesNotExist:
        return Response({"error": "Invalid email or password."}, status=status.HTTP_400_BAD_REQUEST)
    user = authenticate(username=user.username, password=password)
    if user is not None:
        token, created = Token.objects.get_or_create(user=user)
        return Response({"token": token.key}, status=status.HTTP_200_OK)
    else:
        return Response({"error": "Invalid email or password."}, status=status.HTTP_400_BAD_REQUEST)


@api_view(['GET'])
@permission_classes([IsAuthenticated])
def user_profile(request):
    user = request.user
    serializer = UserProfileSerializer(user)
    return Response(serializer.data, status=status.HTTP_200_OK)

# Genetic algorithm


@api_view(['POST'])
@permission_classes([IsAuthenticated])
def optimize_recipes(request):
    if request.method == 'POST':
        inventory = request.data.get('inventory', {})
        selected_recipes = run_genetic_algorithm(inventory)
        response_data = {
            "selected recipes": selected_recipes
        }

        return JsonResponse(response_data, status=200)
