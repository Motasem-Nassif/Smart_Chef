import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'package:smartchef/controller/mainscreencontroller.dart';
import 'package:smartchef/core/constants/appcolors.dart';
import 'package:smartchef/view/screens/Searchmain.dart';
import 'package:smartchef/view/screens/homepage.dart';
import 'package:smartchef/view/screens/IngerdientsScreen.dart';

class MainScreen extends StatelessWidget {
  final MainScreenController controller = Get.put(MainScreenController());
  final List<Widget> screens = [
   // HomePage(),
    SearchMain(),
   // Center(
     // child: Text("screen3"),
    //),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: CurvedNavigationBar(
        height: 50,
        color: AppColor.darkOrange,
        animationDuration: Duration(milliseconds: 200),
        index: controller.currentIndex,
        backgroundColor: Colors.transparent,
        items: const [
          Icon(
            Icons.search,
            size: 30,
            color: Colors.white,
          ),
        ],
        onTap: (index) {
          controller.updateIndex(index);
        },
      ),
      body: GetBuilder<MainScreenController>(
        builder: (controller) {
          return screens[controller.currentIndex];
        },
      ),
    );
  }
}
