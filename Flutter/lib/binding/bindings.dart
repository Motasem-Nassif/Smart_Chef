//import 'package:flutter_application_1/core/classes/Crud.dart';
import 'package:get/get.dart';
import 'package:smartchef/core/classes/crud.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    // Start
    Get.put(Crud());
    //  Get.put(OffersController());
  }
}
