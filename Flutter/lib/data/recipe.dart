import 'dart:convert';

class RecipeList {
  final List<Recipe> selectedRecipes;

  RecipeList({required this.selectedRecipes});

  factory RecipeList.fromJson(Map<String, dynamic> json) {
    return RecipeList(
      selectedRecipes: List<Recipe>.from(json['selected recipes'].map((x) => Recipe.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'selected recipes': List<dynamic>.from(selectedRecipes.map((x) => x.toJson())),
    };
  }
}

class Recipe {
  final String name;
  final Map<String, int> ingredients;
  final NutritionInfo nutritionInfo;
  final List<String> mainIngredients;
  final String instructions;
  final String category;
  final int mealTime;
  final String cuisine;

  Recipe({
    required this.name,
    required this.ingredients,
    required this.nutritionInfo,
    required this.mainIngredients,
    required this.instructions,
    required this.category,
    required this.mealTime,
    required this.cuisine,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      name: json['name'],
      ingredients: Map.from(json['ingredients']).map((k, v) => MapEntry<String, int>(k, v)),
      nutritionInfo: NutritionInfo.fromJson(json['nutrition_info']),
      mainIngredients: List<String>.from(json['main_ingredients']),
      instructions: json['instructions'],
      category: json['category'],
      mealTime: json['meal_time'],
      cuisine: json['cuisine'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'ingredients': Map.from(ingredients).map((k, v) => MapEntry<String, dynamic>(k, v)),
      'nutrition_info': nutritionInfo.toJson(),
      'main_ingredients': List<dynamic>.from(mainIngredients.map((x) => x)),
      'instructions': instructions,
      'category': category,
      'meal_time': mealTime,
      'cuisine': cuisine,
    };
  }
}

class NutritionInfo {
  final int calories;
  final int fatG;
  final int carbohydratesG;
  final int proteinG;

  NutritionInfo({
    required this.calories,
    required this.fatG,
    required this.carbohydratesG,
    required this.proteinG,
  });

  factory NutritionInfo.fromJson(Map<String, dynamic> json) {
    return NutritionInfo(
      calories: json['calories'],
      fatG: json['fat_g'],
      carbohydratesG: json['carbohydrates_g'],
      proteinG: json['protein_g'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'calories': calories,
      'fat_g': fatG,
      'carbohydrates_g': carbohydratesG,
      'protein_g': proteinG,
    };
  }
}
