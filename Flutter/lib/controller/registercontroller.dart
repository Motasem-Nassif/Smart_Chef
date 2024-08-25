import 'package:get/get.dart';

class RegisterController extends GetxController {
  String name = '';
  String email = '';
  String password = '';

  // Disease options
  Map<String, bool> diseases = {
    'Diabetes': false,
    'Obesity': false,
    'Heart Diseases': false,
  };

  void updateName(String value) {
    name = value;
    update(); // Notify listeners to update the UI
  }

  void updateEmail(String value) {
    email = value;
    update(); // Notify listeners to update the UI
  }

  void updatePassword(String value) {
    password = value;
    update(); // Notify listeners to update the UI
  }

  void toggleDisease(String disease) {
    diseases[disease] = !diseases[disease]!;
    update(); // Notify listeners to update the UI
  }
}
