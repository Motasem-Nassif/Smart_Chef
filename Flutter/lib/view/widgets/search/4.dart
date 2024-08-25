/*import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartchef/controller/searchcontroller.dart';
import 'package:smartchef/core/constants/appcolors.dart';
import 'package:smartchef/view/widgets/chatbubble.dart';

class HealthConcern extends StatelessWidget {
  const HealthConcern({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Search1Controller controller = Get.find<Search1Controller>();

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ChatBubble(
              color: AppColor.darkOrange,
              message: 'Should I worry \nabout your health file?',
            ),
            Column(
              children: [
                Image.asset(
                  "assets/images/chef2.png",
                  height: 150,
                  width: 90,
                ),
              ],
            ),
          ],
        ),
        if (controller.healthConcernSelected == null)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  controller.onHealthConcernSelected('Yes');
                },
                child: Text('Yes'),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  controller.onHealthConcernSelected('No');
                },
                child: Text('No'),
              ),
            ],
          ),
        if (controller.healthConcernSelected != null)
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ChatBubble(
                    color: AppColor.darkOrange,
                    message: controller.healthConcernSelected!,
                  ),
                ],
              ),
            ],
          ),
      ],
    );
  }
}
*/