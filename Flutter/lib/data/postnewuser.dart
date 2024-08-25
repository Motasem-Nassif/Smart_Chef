import 'package:smartchef/core/classes/crud.dart';
import 'package:smartchef/core/constants/applinks.dart';

class RegisterRequest {
  Crud crud;
  RegisterRequest(this.crud);

  postData({
    name,
    email,
    password,
    disease,
  }) async {
    var response = await crud.postData(
      AppLinks.signup, // Placeholder for the API endpoint, can be replaced later
      {
        "username": name,
        "email": email,
        "password": password,
        "diseases": disease,
      },
    );

    return response.fold((l) => l, (r) => r);
  }
}
