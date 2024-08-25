import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:smartchef/controller/searchcontroller2.dart';
import 'package:smartchef/core/constants/appcolors.dart';
import 'package:smartchef/data/staticdata.dart';
import 'package:smartchef/view/screens/IngerdientsScreen.dart';
import 'package:smartchef/view/screens/resultscreen.dart';

class SearchMain extends StatelessWidget {
  final SearchController2 controller = Get.put(SearchController2());

  SearchMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(bottom: 100, top: 50.0, left: 8, right: 8),
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
                    height: 150,
                    width: 270,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: AppColor.darkOrange),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "help A.i to recommend you the best dish fits with your requirements please choose Ingerdients from the following categories when you finish click on search button",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: AppColor.white),
                      ),
                    ),
                  ),
                ],
              ),
              //Container(
              // margin: EdgeInsets.only(top: 20),
              //child: Text(
              // "ingerdients categories",
              // style: TextStyle(
              //      fontSize: 20,
              //        color: AppColor.grey,
              //          fontWeight: FontWeight.bold),
              //      ),
              //      ),
              // Ensure GridView is flexible
              Container(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: StaticData.ingredients.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            String category =
                                StaticData.ingredients.keys.elementAt(index);
                            List<String> items = StaticData
                                .ingredients[category]!.values
                                .toList();
                            Get.to(IngerdientsScreen(),
                                arguments: {"index": index, "items": items});
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              image: DecorationImage(
                                image: AssetImage(
                                  StaticData.categoriesImages[index],
                                ),
                                fit: BoxFit.cover,
                              ),
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                Spacer(),
                                Container(
                                  height: 24,
                                  width: 80,
                                  decoration: BoxDecoration(
                                      color: AppColor.lightOrange,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Text(
                                    StaticData.ingredients.keys
                                        .elementAt(index),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              GetBuilder<SearchController2>(
                builder: (controller) {
                  if (controller.chosenItems.isNotEmpty) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //          SizedBox(height: 5),
                        const Text(
                          'What You Chose',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
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
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                print(controller.chosenItems);
                                controller.postData();

                                Get.to(ResultScreen());

                                print(controller.chosenItems);
                              },
                              child: Container(
                                height: 35,
                                width: 150,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: AppColor.darkOrange),
                                child: Center(
                                  child: Text(
                                    "Start Searching",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: AppColor.white),
                                  ),
                                ),
                              ),
                            ),
                            Spacer()
                          ],
                        )
                      ],
                    );
                  } else {
                    return SizedBox.shrink();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
