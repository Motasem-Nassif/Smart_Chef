import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartchef/controller/searchcontroller2.dart';
import 'package:smartchef/core/constants/appcolors.dart';
import 'package:smartchef/view/screens/dishdetail.dart';

class DishCardWidget extends StatelessWidget {
  final String image, name, cooktime;
  VoidCallback function;
  DishCardWidget({
    Key? key,
    required this.image,
    required this.name,
    required this.cooktime,
    required this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SearchController2 controller = Get.put(SearchController2());
    return GestureDetector(
      onTap: () {
        // If you want to perform some operation before calling the function, do it here
        // function(); // This will call the function passed as a parameter
      },
      child: Container(
        height: 200,
        width: 200,
        decoration: BoxDecoration(
          color: AppColor.lightOrange,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Image.asset(
              image,
              height: 130,
              width: 150,
              fit: BoxFit.fill,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    name,
                    style: TextStyle(
                      color: AppColor.lightGrey,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(width: 15),
                Text(
                  cooktime,
                  style: TextStyle(color: AppColor.lightGrey, fontSize: 12),
                ),
                Icon(Icons.alarm, color: AppColor.lightGrey, size: 12),
              ],
            ),
            Container(
              height: 30,
              width: 140,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColor.orange,
              ),
              child: Center(
                child: Text(
                  "Details",
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
