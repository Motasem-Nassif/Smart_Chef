/*import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartchef/controller/searchcontroller.dart';
import 'package:smartchef/core/constants/appcolors.dart';
import 'package:smartchef/view/widgets/chatbubble.dart';

class FilterSelection extends StatelessWidget {
  const FilterSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Search1Controller controller = Get.find<Search1Controller>();

    return Column(
      children: [
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
              SizedBox(height: 20),
              if (controller.availableFilters.isNotEmpty)
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ChatBubble(
                      color: AppColor.darkOrange,
                      message: 'Add more filter?',
                    ),
                    Column(
                      children: [],
                    ),
                    Image.asset(
                      "assets/images/chef2.png",
                      height: 150,
                      width: 90,
                    ),
                  ],
                ),
              if (controller.addFilterSelected == null &&
                  controller.availableFilters.isNotEmpty)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        controller.onAddFilterSelected('Yes');
                      },
                      child: Text('Yes'),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        controller.onAddFilterSelected('No');
                      },
                      child: Text('No'),
                    ),
                  ],
                ),
              if (controller.addFilterSelected != null)
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ChatBubble(
                          color: AppColor.darkOrange,
                          message: controller.addFilterSelected!,
                        ),
                      ],
                    ),
                    if (controller.addFilterSelected == 'Yes')
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: controller.availableFilters.map((filter) {
                          return ListTile(
                            title: Text('Filter based on ${filter}'),
                            onTap: () {
                              controller.onFilterSelected(filter);
                            },
                          );
                        }).toList(),
                      ),
                  ],
                ),
              if (controller.selectedFilter == 'meal')
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ListTile(
                      title: Text('AM'),
                      onTap: () {
                        controller.onMealTimeSelected('AM');
                      },
                    ),
                    ListTile(
                      title: Text('Noon'),
                      onTap: () {
                        controller.onMealTimeSelected('Noon');
                      },
                    ),
                    ListTile(
                      title: Text('Evening'),
                      onTap: () {
                        controller.onMealTimeSelected('Evening');
                      },
                    ),
                  ],
                ),
              if (controller.selectedFilter == 'preparation')
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextField(
                      controller: controller.minutesController,
                      decoration: InputDecoration(labelText: 'Minutes'),
                    ),
                    TextField(
                      controller: controller.hoursController,
                      decoration: InputDecoration(labelText: 'Hours'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        controller.onPreparationTimeSelected();
                      },
                      child: Text('Submit'),
                    ),
                  ],
                ),
              if (controller.selectedFilter == 'kitchen')
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextField(
                      controller: controller.kitchenTypeController,
                      decoration: InputDecoration(labelText: 'Kitchen Type'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        controller.onKitchenTypeSelected();
                      },
                      child: Text('Submit'),
                    ),
                  ],
                ),
              if (controller.selectedFilter == 'dish')
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ListTile(
                      title: Text('Appetizers'),
                      onTap: () {
                        controller.onDishTypeSelected('Appetizers');
                      },
                    ),
                    ListTile(
                      title: Text('Main Meal'),
                      onTap: () {
                        controller.onDishTypeSelected('Main Meal');
                      },
                    ),
                    ListTile(
                      title: Text('Desserts'),
                      onTap: () {
                        controller.onDishTypeSelected('Desserts');
                      },
                    ),
                    ListTile(
                      title: Text('Snacks'),
                      onTap: () {
                        controller.onDishTypeSelected('Snacks');
                      },
                    ),
                  ],
                ),
              if (controller.showDoneButton)
                ElevatedButton(
                  onPressed: () {
                    controller.onDoneFiltering();
                  },
                  child: Text('Done'),
                ),
            ],
          ),
      ],
    );
  }
}
*/