import 'dart:convert';

import 'package:smartchef/core/classes/crud.dart';
import 'package:smartchef/core/constants/applinks.dart';

class FilterRequestReomte {
  Crud crud;
  FilterRequestReomte(this.crud);

  postData({
    ingredients,
    disease,
    mealtime,
    mealduration,
    dishtype,
    caloriesRange,
    sugarsRange,
    saturatedFatRange,
    cholesterolRange,
    proteinRange,
    dietaryFiberRange,
    sodiumRange,
    caloriesFromFatRange,
    calciumRange,
    ironRange,
    magnesiumRange,
    potassiumRange,
    dishRegion,
  }) async {
    var response = await crud.postData(
        AppLinks.searchRexipelink, // Placeholder for the API endpoint, can be replaced later

        {
          "inventory": ingredients,
        }

        //     "disease": disease,
        //   "mealtime": mealtime,
        // "mealduration": mealduration,
        // "dishtype": dishtype,
        // "caloriesRange": caloriesRange,
        // "sugarsRange": sugarsRange,
        // "saturatedFatRange": saturatedFatRange,
        // "cholesterolRange": cholesterolRange,
        // "proteinRange": proteinRange,
        // "dietaryFiberRange": dietaryFiberRange,
        // "sodiumRange": sodiumRange,
        // "caloriesFromFatRange": caloriesFromFatRange,
        //  "calciumRange": calciumRange,
        // "ironRange": ironRange,
        //    "magnesiumRange": magnesiumRange,
        //      "potassiumRange": potassiumRange,
//        "dishRegion": dishRegion,
        // }

        );

    return response.fold((l) => l, (r) => r);
  }
}
