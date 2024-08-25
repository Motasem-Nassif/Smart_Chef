import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartchef/core/classes/statusrequest.dart';
import 'package:smartchef/core/functions/handlingrequest.dart';
import 'package:smartchef/data/postrequest.dart';
import 'package:smartchef/data/recipe.dart'; // Make sure to include your Recipe model here.

class SearchController2 extends GetxController {
  TextEditingController inputController = TextEditingController();
  List<String> allItems = [];
  List<String> filteredItems = [];
  List<String> chosenItems = [];
  late StatusRequest postingStatus;

  FilterRequestReomte remote = FilterRequestReomte(Get.find());
  List<Recipe> recipeBase = []; // Use Recipe from your provided Recipe model

  SearchController2() {
    filteredItems = List.from(allItems); // Initially display all items
  }

  // Update the list based on the search query
  void updateSearch(String query) {
    if (query.isEmpty) {
      filteredItems =
          List.from(allItems); // Show all items if search field is empty
    } else if (query.length >= 3) {
      // Filter items by query if it has at least 3 letters
      filteredItems = allItems
          .where((item) => item.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    update(); // Trigger UI update
  }

  // Post data and handle response
  Future<void> postData() async {
    postingStatus = StatusRequest.loading;
    var response = await remote
        .postData(ingredients: {for (var item in chosenItems) item: 3});
    postingStatus = handlingData(response);
    update();

    if (postingStatus == StatusRequest.success) {
      if (response['selected recipes'] != null) {
        List<dynamic> rec = response['selected recipes'];
        List<Recipe> parsedData =
            rec.map((json) => Recipe.fromJson(json)).toList();
        Set<String> existingNames =
            Set<String>(); // To track existing recipe names
        recipeBase.clear();

        // Loop through the parsed data and add only unique recipes based on name
        for (Recipe recipe in parsedData) {
          if (!existingNames.contains(recipe.name)) {
            recipeBase.add(recipe);
            existingNames.add(
                recipe.name); // Add the name to the set to track uniqueness
          }
        }

        update();
      } else {
        Get.snackbar("Error", "An error occurred, please try again later.");
        postingStatus = StatusRequest.failure;
        update();
      }
    }
  }

  // Toggle selection of an item
  void toggleSelection(String item) {
    if (chosenItems.contains(item)) {
      chosenItems.remove(item);
    } else {
      chosenItems.add(item);
    }
    update(); // Trigger UI update
  }

  // Check if an item is chosen
  bool isChosen(String item) {
    return chosenItems.contains(item);
  }
}
