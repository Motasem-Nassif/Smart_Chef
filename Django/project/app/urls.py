from django.urls import path
from . import views
from .views import suggest_recipes,recipes_information
from .views import user_signup,login_view,user_profile



urlpatterns = [
    path('Genetic_algorithm/', views.optimize_recipes),
    path('recipes_information/', views.recipes_information),
    path('filter_recipes/', views.filter_recipes_view),
    path('recommended_based_rate/', views.recommeded_based_rate),
    path('recommend_similar_recipes_by_ingredients/', views.recommend_similar_recipes_by_ingredients),
    path('api/signup/', user_signup, name='user_signup'),
    path('api/login/', login_view, name='login'),
    path('api/profile/',user_profile,name='profile')
]









