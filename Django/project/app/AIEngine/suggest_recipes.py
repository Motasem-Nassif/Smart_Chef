import pandas as pd
import numpy as np
import json
from django.http import JsonResponse


class RecipeSuggester:
    def __init__(self, csv_file):
        self.df = pd.read_csv(csv_file)

    def categorize_ingredients(self, ingredient):
        main_dish_ingredients = {'chicken', 'beef', 'lamb', 'rice', 'potato', 'pasta',
                                 'shrimp', 'crabmeat', 'salmon', 'garbanzo', 'turkey', 'steaks', 'eggs'}
        salad_ingredients = {'lettuce', 'cabbage', 'radishes', 'cucumber', 'tomato', 'onion', 'garlic',
                             'parsley', 'mint', 'olive oil', 'pomegranate', 'broccoli', 'celery', 'carrot', 'bell pepper'}
        dessert_ingredients = {'sugar', 'white sugar', 'flour', 'butter', 'milk', 'cream cheese', 'vanilla', 'eggs', 'cocoa powder',
                               'honey', 'lemon juice', 'baking powder', 'cinnamon', 'chocolate', 'apples', 'dates', 'pecans', 'strawberries'}
        spices_seasonings = {'salt', 'pepper', 'oregano', 'basil', 'rosemary', 'thyme', 'cumin', 'paprika',
                             'garlic powder', 'onion powder', 'chili powder', 'ginger', 'nutmeg', 'allspice', 'cardamom', 'coriander'}

        ingredient = ingredient.lower().strip()

        if ingredient in main_dish_ingredients:
            return 'main_dish'
        elif ingredient in salad_ingredients:
            return 'salad'
        elif ingredient in dessert_ingredients:
            return 'dessert'
        elif ingredient in spices_seasonings:
            return 'spices_seasonings'
        else:
            return 'other_ingredients'

    def rule_based_meal_suggestion(self, ingredients):
        suggestions = {
            'main_dish': [],
            'salad': [],
            'dessert': [],
            'spices_seasonings': [],
            'other_ingredients': []
        }

        for ingredient in ingredients:
            category = self.categorize_ingredients(ingredient)
            suggestions[category].append(ingredient)

        meals = []
        if suggestions['main_dish']:
            meals.append(
                f"Main Dish: {' and '.join(suggestions['main_dish'])}")
        if suggestions['salad']:
            meals.append(f"Salad: {' and '.join(suggestions['salad'])}")
        if suggestions['dessert']:
            meals.append(f"Dessert: {' and '.join(suggestions['dessert'])}")
        if suggestions['spices_seasonings']:
            meals.append(
                f"Spices/Seasonings: {' and '.join(suggestions['spices_seasonings'])}")
        if suggestions['other_ingredients']:
            meals.append(
                f"Other Ingredients: {' and '.join(suggestions['other_ingredients'])}")

        dataset_suggestions = []
        for index, row in self.df.iterrows():
            recipe_ingredients = set(
                map(lambda x: x.strip().lower(), row['Cleaned_Ingredients'].split(',')))
            main_ingredients = set(
                map(lambda x: x.strip().lower(), row['main ingredients'].split(',')))
            common_ingredients = recipe_ingredients.intersection(
                set(ingredients))
            common_main_ingredients = main_ingredients.intersection(
                set(ingredients))

            match_percentage = len(common_ingredients) / \
                len(recipe_ingredients)
            match_main_ingredients = len(
                common_main_ingredients) / len(main_ingredients)

            if common_ingredients and match_percentage > 0.2 and match_main_ingredients > 0.5:  # Filter for match percentage > 50%
                dataset_suggestions.append({
                    'name': row['name'],
                    "category": row["category"],
                    "Cleaned_Ingredients": row["Cleaned_Ingredients"],
                    "main ingredients": row["main ingredients"],
                    "cuisine": row["cuisine"],
                    "servings": row['servings'],
                    "total": row['total'],
                    "meal time": row["meal time"],
                    'common_ingredients': list(common_ingredients),
                    'common_main_ingredients': list(common_main_ingredients),
                    'match_percentage': match_percentage,
                    'match_main_ingredients': match_main_ingredients
                })

        dataset_suggestions = sorted(
            dataset_suggestions, key=lambda x: x['match_main_ingredients'], reverse=True)

        return dataset_suggestions

    def get_meal_details_by_name(self, meal_name):
        columns_to_return = [
            'name', 'meal time', 'category', 'directions', 'total', 'servings',
            'calories', 'carbohydrates_g', 'sugars_g', 'fat_g', 'saturated_fat_g',
            'cholesterol_mg', 'protein_g', 'dietary_fiber_g', 'sodium_mg',
            'calories_from_fat', 'calcium_mg', 'iron_mg', 'magnesium_mg',
            'potassium_mg', 'vitamin_a_iu_IU', 'niacin_equivalents_mg',
            'vitamin_c_mg', 'folate_mcg', 'thiamin_mg', 'cuisine',
            'Quantities', 'Units', 'Ingredients'
        ]

        meal_details = self.df.loc[self.df['name'].str.lower(
        ) == meal_name.lower(), columns_to_return]

        if meal_details.empty:
            return f"No meal found with the name '{meal_name}'"

        meal_info = meal_details.iloc[0].to_dict()

        return [meal_info]

    def recommend_top_rated_recipes(self):
        top_recipes = self.df.sort_values(by='rating', ascending=False).head()
        top_recipes = top_recipes[['name', 'rating',
                                   'category', 'cuisine', 'servings', 'meal time']]
        grouped_recipes = top_recipes.groupby('category').apply(
            lambda x: x.to_dict(orient='records')).to_dict()

        return grouped_recipes

    def recommend_similar_recipes_by_ingredients(selected_dishes, data, top_n=5):
        filtered_data = data[data['name'].isin(selected_dishes)]
        selected_ingredients = set()

        for _, dish in filtered_data.iterrows():
            dish_ingredients = set(
                dish['Cleaned_Ingredients'].lower().split(', '))
            selected_ingredients.update(dish_ingredients)

        def ingredient_similarity(row):
            recipe_ingredients = set(
                row['Cleaned_Ingredients'].lower().split(', '))
            common_ingredients = selected_ingredients.intersection(
                recipe_ingredients)
            return len(common_ingredients)

        data['similarity'] = data.apply(ingredient_similarity, axis=1)

        selected_names = set(filtered_data['name'])
        similar_recipes = data[~data['name'].isin(selected_names)]
        top_recommendations = similar_recipes.sort_values(
            by=['similarity', 'rating'], ascending=[False, False]).head(top_n)

        return top_recommendations[['name', 'rating', 'category', 'cuisine', 'servings', 'meal time']]

    def filter_recipes(self, recipes, filter_criteria):
        filter_criteria = filter_criteria[0]
        detailed_recipes = []
        for recipe in recipes:
            detailed_recipes += self.get_meal_details_by_name(recipe['name'])
        recipes_df = pd.DataFrame(detailed_recipes)

        for key, value in filter_criteria.items():
            if key == 'meal time':
                filter_meal_times = set(value.split(','))
                recipes_df = recipes_df[recipes_df[key].apply(
                    lambda x: filter_meal_times.issubset(set(x.split(','))))]
            elif key == 'nutrition facts':
                for nutrition_key, nutrition_value in value.items():
                    if isinstance(nutrition_value, dict):
                        min_val = nutrition_value.get('min', None)
                        max_val = nutrition_value.get('max', None)
                        if min_val is not None:
                            min_val = float(min_val)
                            recipes_df = recipes_df[recipes_df[nutrition_key].astype(
                                float) >= min_val]
                        if max_val is not None:
                            max_val = float(max_val)
                            recipes_df = recipes_df[recipes_df[nutrition_key].astype(
                                float) >= max_val]
                    else:
                        recipes_df = recipes_df[recipes_df[nutrition_key].astype(
                            float) == float(nutrition_value)]
            else:
                recipes_df = recipes_df[recipes_df[key] == value]

        return recipes_df
