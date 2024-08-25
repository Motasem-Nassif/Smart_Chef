import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class ResultController extends GetxController {
  bool iconcheck1 = false;
  bool iconcheck2 = false;
  bool iconcheck3 = false;
  bool iconcheck4 = false;
  bool iconcheck5 = false;
  bool iconcheck6 = false; // New icon check for Dish Region

  // These will track the selection state of each option for diseases
  Map<String, bool> options = {
    'Diabetes': false,
    'Obesity': false,
    'Heart Diseases': false,
  };

  // These will track the selection state of each option for mealtime
  Map<String, bool> mealtimeOptions = {
    'Breakfast': false,
    'Lunch': false,
    'Dinner': false,
  };

  Map<String, bool> dishtypeoption = {
    "world-cuisine": false,
    "seafood": false,
    "main-dish": false,
    "appetizers-and-snacks": false,
    "side-dish": false,
    "soups-stews-and-chili": false,
    "meat-and-poultry": false,
    "salad": false,
    "desserts": false,
    "breakfast-and-brunch": false,
    "trusted-brands-recipes-and-tips": false,
    "bread": false,
    "uncategorized": false,
    "everyday-cooking": false,
    "drinks": false,
    "fruits-and-vegetables": false,
    "pasta-and-noodles": false,
  };

  // New Map for Dish Region
  Map<String, bool> dishRegionOption = {
    "Middle East": false,
    "Lebanese": false,
    "Italian": false,
    "Turkish": false,
  };

  // Variable to store the selected duration
  Duration selectedDuration = Duration(minutes: 30);

  // Variables to store range slider values
  RangeValues caloriesRange = RangeValues(1.1, 1657.1);
  RangeValues carbohydratesRange = RangeValues(0.1, 246.0);
  RangeValues sugarsRange = RangeValues(0.0, 125.7);
  RangeValues fatRange = RangeValues(0.0, 153.3);
  RangeValues saturatedFatRange = RangeValues(0.0, 81.7);
  RangeValues cholesterolRange = RangeValues(0.0, 1685.8);
  RangeValues proteinRange = RangeValues(0.0, 183.2);
  RangeValues dietaryFiberRange = RangeValues(0.0, 26.0);
  RangeValues sodiumRange = RangeValues(0.2, 121298.3);
  RangeValues caloriesFromFatRange = RangeValues(0.1, 1379.7);
  RangeValues calciumRange = RangeValues(0.1, 1376.9);
  RangeValues ironRange = RangeValues(0.0, 54.6);
  RangeValues magnesiumRange = RangeValues(0.1, 425.3);
  RangeValues potassiumRange = RangeValues(0.5, 3650.3);

  void iconchange1() {
    iconcheck1 = !iconcheck1;
    update();
  }

  void iconchange2() {
    iconcheck2 = !iconcheck2;
    update();
  }

  void iconchange3() {
    iconcheck3 = !iconcheck3;
    update();
  }

  void iconchange4() {
    iconcheck4 = !iconcheck4;
    update();
  }

  void iconchange5() {
    iconcheck5 = !iconcheck5;
    update();
  }

  void iconchange6() {
    iconcheck6 = !iconcheck6;
    update();
  }

  void toggleOption(String option) {
    options[option] = !options[option]!;
    update();
  }

  void toggletypeOption(String option2) {
    dishtypeoption[option2] = !dishtypeoption[option2]!;
    update();
  }

  void toggleRegionOption(String option) {
    dishRegionOption[option] = !dishRegionOption[option]!;
    update();
  }

  // Method to handle single selection for mealtime options
  void toggleMealtimeOption(String option) {
    mealtimeOptions.forEach((key, value) {
      mealtimeOptions[key] = false;
    });
    mealtimeOptions[option] = true;
    update();
  }

  // Method to update the selected duration
  void updateDuration(Duration duration) {
    selectedDuration = duration;
    update();
  }

  // Methods to update each nutritional range
  void updateCaloriesRange(RangeValues newRange) {
    caloriesRange = newRange;
    update();
  }

  void updateCarbohydratesRange(RangeValues newRange) {
    carbohydratesRange = newRange;
    update();
  }

  void updateSugarsRange(RangeValues newRange) {
    sugarsRange = newRange;
    update();
  }

  void updateFatRange(RangeValues newRange) {
    fatRange = newRange;
    update();
  }

  void updateSaturatedFatRange(RangeValues newRange) {
    saturatedFatRange = newRange;
    update();
  }

  void updateCholesterolRange(RangeValues newRange) {
    cholesterolRange = newRange;
    update();
  }

  void updateProteinRange(RangeValues newRange) {
    proteinRange = newRange;
    update();
  }

  void updateDietaryFiberRange(RangeValues newRange) {
    dietaryFiberRange = newRange;
    update();
  }

  void updateSodiumRange(RangeValues newRange) {
    sodiumRange = newRange;
    update();
  }

  void updateCaloriesFromFatRange(RangeValues newRange) {
    caloriesFromFatRange = newRange;
    update();
  }

  void updateCalciumRange(RangeValues newRange) {
    calciumRange = newRange;
    update();
  }

  void updateIronRange(RangeValues newRange) {
    ironRange = newRange;
    update();
  }

  void updateMagnesiumRange(RangeValues newRange) {
    magnesiumRange = newRange;
    update();
  }

  void updatePotassiumRange(RangeValues newRange) {
    potassiumRange = newRange;
    update();
  }
}
