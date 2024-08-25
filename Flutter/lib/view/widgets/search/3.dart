/*import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:smartchef/controller/searchcontroller.dart';
import 'package:smartchef/core/constants/appcolors.dart';
import 'package:smartchef/view/widgets/chatbubble.dart';

class IngredientDisplay extends StatelessWidget {
  const IngredientDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Search1Controller controller = Get.find<Search1Controller>();

    return Column(
      children: [
        Container(
          height: 250,
          width: 250,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            image: DecorationImage(
              image: AssetImage("assets/images/menu.jpg"),
              fit: BoxFit.fill,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              top: 60,
              left: 20,
              right: 20,
              bottom: 20,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: controller.ingerdiendsInputData.map((ingredientData) {
                  return AnimatedTextKit(
                    animatedTexts: [
                      TyperAnimatedText(
                        '${ingredientData['ingredient']}: ${ingredientData['amount']} ${ingredientData['unit']}',
                        textStyle: TextStyle(fontFamily: "Margarine"),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ),
        SizedBox(height: 20),
        Column(
          children: controller.filterMessages.map((message) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ChatBubble(
                  color: AppColor.darkOrange,
                  message: message,
                ),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }
}
*/