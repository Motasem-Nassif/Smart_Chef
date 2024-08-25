import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartchef/controller/searchcontroller2.dart';
import 'package:smartchef/core/constants/appcolors.dart';

class IngerdientsScreen extends StatelessWidget {
  final SearchController2 controller = Get.put(SearchController2());

  @override
  Widget build(BuildContext context) {
    // Retrieve the passed arguments
    final Map args = Get.arguments;
    final List<String> items = args['items'] as List<String>;

    // Update the controller's allItems with the passed items
    controller.allItems = List.from(items);
    controller.filteredItems = List.from(items); // Initially display all items

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(bottom: 10, top: 80.0, left: 8, right: 8),
        child: SingleChildScrollView(
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
                    height: 90,
                    width: 270,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: AppColor.darkOrange),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "if there are alot of ingerdients here just search for them right in the bix down",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: AppColor.white),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                height: 60,
                width: 450,
                child: TextField(
                  controller: controller.inputController,
                  onSubmitted: (value) {
                    controller.inputController.clear();
                  },
                  decoration: InputDecoration(
                    hintText: 'Search',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                  onChanged: (value) {
                    controller.updateSearch(value);
                  },
                ),
              ),
              SizedBox(height: 20),
              GetBuilder<SearchController2>(
                builder: (controller) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // GridView for displaying items
                      Container(
                        height: 500,
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemCount: controller.filteredItems.length,
                          itemBuilder: (context, index) {
                            String item = controller.filteredItems[index];
                            bool isSelected = controller.isChosen(item);

                            return GestureDetector(
                              onTap: () {
                                controller.toggleSelection(item);
                                controller.inputController.clear();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? AppColor.lightOrange
                                      : Colors.grey[200],
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    item,
                                    style: TextStyle(
                                      color: isSelected
                                          ? Colors.white
                                          : Colors.black,
                                      fontWeight: isSelected
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      // "What You Chose" section
                      if (controller.chosenItems.isNotEmpty) ...[
                        SizedBox(height: 20),
                        Text(
                          'What You Chose',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          child: Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children: [
                              for (String item in controller.chosenItems)
                                Chip(
                                  key: ValueKey(item),
                                  label: Text(item),
                                  onDeleted: () {
                                    controller.toggleSelection(item);
                                  },
                                ),
                            ],
                          ),
                        )
                      ],
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
