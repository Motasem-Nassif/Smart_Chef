
import 'dart:convert';

import 'package:smartchef/core/classes/crud.dart';
import 'package:smartchef/core/constants/applinks.dart';

class dishdetailsRequest {
  Crud crud;
  dishdetailsRequest(this.crud);

  postData({
   name,
  }) async {
    var response = await crud.postData(
      AppLinks.recpieinfolink, // Placeholder for the API endpoint, can be replaced later
      
   {   
    "name": name,
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
