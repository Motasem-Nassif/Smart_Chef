import 'package:get/get.dart';

class UnitConverterController extends GetxController {
  double result = 0.0;

  void convert(double input, String inputUnit, String outputUnit) {
    if (inputUnit == 'grams' && outputUnit == 'tablespoons') {
      result = input * 0.067; // Example conversion rate
    } else if (inputUnit == 'grams' && outputUnit == 'teaspoons') {
      result = input * 0.2; // Example conversion rate
    } else if (inputUnit == 'liters' && outputUnit == 'cups') {
      result = input * 4.22675; // Example conversion rate
    } else if (inputUnit == 'grams' && outputUnit == 'cups') {
      result = input / 240; // Example conversion rate for milk
    }
    update(); // Update the UI
  }

  void clearResult() {
    result = 0.0;
    update(); // Update the UI
  }
}
