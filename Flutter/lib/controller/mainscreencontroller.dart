import 'package:get/get.dart';

class MainScreenController extends GetxController {
  var currentIndex = 0;

  void updateIndex(int index) {
    currentIndex = index;
    update();
  }
}
