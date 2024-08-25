class dishdetails {
  Recipes? recipes;

  dishdetails({this.recipes});

  dishdetails.fromJson(Map<String, dynamic> json) {
    recipes =
        json['recipes'] != null ? new Recipes.fromJson(json['recipes']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.recipes != null) {
      data['recipes'] = this.recipes!.toJson();
    }
    return data;
  }
}

class Recipes {
  String? name;
  String? mealTime;
  String? mainIngredients;
  String? cleanedIngredients;
  String? url;
  String? category;
  String? author;
  String? summary;
  double? rating;
  int? ratingCount;
  int? reviewCount;
  String? ingredients;
  String? directions;
  String? prep;
  String? cook;
  String? total;
  int? servings;
  String? yield;
  double? calories;
  double? carbohydratesG;
  double? sugarsG;
  double? fatG;
  double? saturatedFatG;
  int? cholesterolMg;
  double? proteinG;
  double? dietaryFiberG;
  double? sodiumMg;
  double? caloriesFromFat;
  double? calciumMg;
  double? ironMg;
  int? magnesiumMg;
  double? potassiumMg;
  double? vitaminAIuIU;
  double? niacinEquivalentsMg;
  double? vitaminCMg;
  double? folateMcg;
  double? thiaminMg;
  String? cuisine;
  String? quantities;
  String? units;
  String? ingredients2;

  Recipes(
      {this.name,
      this.mealTime,
      this.mainIngredients,
      this.cleanedIngredients,
      this.url,
      this.category,
      this.author,
      this.summary,
      this.rating,
      this.ratingCount,
      this.reviewCount,
      this.ingredients,
      this.directions,
      this.prep,
      this.cook,
      this.total,
      this.servings,
      this.yield,
      this.calories,
      this.carbohydratesG,
      this.sugarsG,
      this.fatG,
      this.saturatedFatG,
      this.cholesterolMg,
      this.proteinG,
      this.dietaryFiberG,
      this.sodiumMg,
      this.caloriesFromFat,
      this.calciumMg,
      this.ironMg,
      this.magnesiumMg,
      this.potassiumMg,
      this.vitaminAIuIU,
      this.niacinEquivalentsMg,
      this.vitaminCMg,
      this.folateMcg,
      this.thiaminMg,
      this.cuisine,
      this.quantities,
      this.units,
      this.ingredients2});

  Recipes.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    mealTime = json['meal time'];
    mainIngredients = json['main ingredients'];
    cleanedIngredients = json['Cleaned_Ingredients'];
    url = json['url'];
    category = json['category'];
    author = json['author'];
    summary = json['summary'];
    rating = json['rating'];
    ratingCount = json['rating_count'];
    reviewCount = json['review_count'];
    ingredients = json['ingredients'];
    directions = json['directions'];
    prep = json['prep'];
    cook = json['cook'];
    total = json['total'];
    servings = json['servings'];
    yield = json['yield'];
    calories = json['calories'];
    carbohydratesG = json['carbohydrates_g'];
    sugarsG = json['sugars_g'];
    fatG = json['fat_g'];
    saturatedFatG = json['saturated_fat_g'];
    cholesterolMg = json['cholesterol_mg'];
    proteinG = json['protein_g'];
    dietaryFiberG = json['dietary_fiber_g'];
    sodiumMg = json['sodium_mg'];
    caloriesFromFat = json['calories_from_fat'];
    calciumMg = json['calcium_mg'];
    ironMg = json['iron_mg'];
    magnesiumMg = json['magnesium_mg'];
    potassiumMg = json['potassium_mg'];
    vitaminAIuIU = json['vitamin_a_iu_IU'];
    niacinEquivalentsMg = json['niacin_equivalents_mg'];
    vitaminCMg = json['vitamin_c_mg'];
    folateMcg = json['folate_mcg'];
    thiaminMg = json['thiamin_mg'];
    cuisine = json['cuisine'];
    quantities = json['Quantities'];
    units = json['Units'];
    ingredients = json['Ingredients'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['meal time'] = this.mealTime;
    data['main ingredients'] = this.mainIngredients;
    data['Cleaned_Ingredients'] = this.cleanedIngredients;
    data['url'] = this.url;
    data['category'] = this.category;
    data['author'] = this.author;
    data['summary'] = this.summary;
    data['rating'] = this.rating;
    data['rating_count'] = this.ratingCount;
    data['review_count'] = this.reviewCount;
    data['ingredients'] = this.ingredients;
    data['directions'] = this.directions;
    data['prep'] = this.prep;
    data['cook'] = this.cook;
    data['total'] = this.total;
    data['servings'] = this.servings;
    data['yield'] = this.yield;
    data['calories'] = this.calories;
    data['carbohydrates_g'] = this.carbohydratesG;
    data['sugars_g'] = this.sugarsG;
    data['fat_g'] = this.fatG;
    data['saturated_fat_g'] = this.saturatedFatG;
    data['cholesterol_mg'] = this.cholesterolMg;
    data['protein_g'] = this.proteinG;
    data['dietary_fiber_g'] = this.dietaryFiberG;
    data['sodium_mg'] = this.sodiumMg;
    data['calories_from_fat'] = this.caloriesFromFat;
    data['calcium_mg'] = this.calciumMg;
    data['iron_mg'] = this.ironMg;
    data['magnesium_mg'] = this.magnesiumMg;
    data['potassium_mg'] = this.potassiumMg;
    data['vitamin_a_iu_IU'] = this.vitaminAIuIU;
    data['niacin_equivalents_mg'] = this.niacinEquivalentsMg;
    data['vitamin_c_mg'] = this.vitaminCMg;
    data['folate_mcg'] = this.folateMcg;
    data['thiamin_mg'] = this.thiaminMg;
    data['cuisine'] = this.cuisine;
    data['Quantities'] = this.quantities;
    data['Units'] = this.units;
    data['Ingredients'] = this.ingredients;
    return data;
  }
}
