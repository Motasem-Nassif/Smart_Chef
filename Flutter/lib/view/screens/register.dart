import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartchef/controller/registercontroller.dart';
import 'package:smartchef/core/constants/appcolors.dart';
import 'package:smartchef/view/screens/mainscreen.dart';

class RegisterUserScreen extends StatelessWidget {
  const RegisterUserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RegisterController controller = Get.put(RegisterController());

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50, left: 8, right: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(
                  "assets/images/chef2.png",
                  height: 120,
                  width: 70,
                  fit: BoxFit.fill,
                ),
                Container(
                  height: 40,
                  width: 270,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColor.darkOrange,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "please enter your details",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: AppColor.white),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                  labelText: 'Name'),
              onChanged: (value) {
                controller.updateName(value);
              },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Email'),
              onChanged: (value) {
                controller.updateEmail(value);
              },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
              onChanged: (value) {
                controller.updatePassword(value);
              },
            ),
            SizedBox(height: 20),
            Text(
              'Select Diseases:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            GetBuilder<RegisterController>(
              builder: (_) {
                return Column(
                  children: controller.diseases.keys.map((disease) {
                    return CheckboxListTile(
                      checkColor: AppColor.white,
                      activeColor: AppColor.darkOrange,
                      title: Text(disease),
                      value: controller.diseases[disease],
                      onChanged: (value) {
                        controller.toggleDisease(disease);
                      },
                    );
                  }).toList(),
                );
              },
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Get.to(MainScreen());
                },
                child: Text('Register'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
