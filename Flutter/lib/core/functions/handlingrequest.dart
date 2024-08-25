//import 'package:flutter_application_1/core/classes/statusrequest.dart';


import 'package:smartchef/core/classes/statusrequest.dart';

handlingData(response) {
  if (response is StatusRequest) {
    return response;
  } else {
    return StatusRequest.success;
  }
}
