import 'package:get/get.dart';

class DishDetailController extends GetxController {
  double firstContainerHeightPercentage =
      0.30; // Set to 1/4 of the screen height
  double secondContainerHeightPercentage =
      0.70; // Set to 3/4 of the screen height
  int servings = 1;

  void plusserving() {
    servings++;
    update();
    print("m");
  }

  void minusserving() {
    if (servings > 1) {
      servings--;
    }
    update();
  }

  void updateContainerHeight(double delta) {
    // Clamp the new height percentages to ensure they stay within the desired bounds
    double newFirstContainerHeight =
        (firstContainerHeightPercentage - delta).clamp(0.25, 0.5);
    double newSecondContainerHeight = 1.0 - newFirstContainerHeight;

    firstContainerHeightPercentage = newFirstContainerHeight;
    secondContainerHeightPercentage = newSecondContainerHeight;
    update();
  }
}
