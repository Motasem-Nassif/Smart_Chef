import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartchef/controller/resultcontroller.dart';
import 'package:smartchef/controller/searchcontroller2.dart';
import 'package:smartchef/core/constants/appcolors.dart';
import 'package:smartchef/view/screens/dishdetail.dart';
import 'package:smartchef/view/widgets/dishcardwidget.dart';
import 'package:smartchef/view/widgets/filteringrectangle.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50, left: 8, right: 8),
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
                    height: 60,
                    width: 270,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: AppColor.darkOrange,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "The following results fit your health situation",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: AppColor.white),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Text(
                  "Results",
                  style: TextStyle(
                    fontSize: 20,
                    color: AppColor.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox.shrink(),
              Container(
                height: 200,
                child: GetBuilder<SearchController2>(
                    init: SearchController2(),
                    builder: (controller) {
                      if (controller.recipeBase.isEmpty) {
                        return CircularProgressIndicator();
                      } else
                        return ListView.separated(
                          separatorBuilder: (context, index) => SizedBox(
                            width: 5,
                          ),
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.recipeBase.length,
                          itemBuilder: (context, index) => DishCardWidget(
                            function: () {
                              Get.to(() => DishDetailScreen(), arguments: {
                                "name": controller.recipeBase[index].name,
                                "calories": controller
                                    .recipeBase[index].nutritionInfo.calories
                                    .toString(),
                                "fat": controller
                                    .recipeBase[index].nutritionInfo.fatG
                                    .toString(),
                                "protin": controller
                                    .recipeBase[index].nutritionInfo.proteinG
                                    .toString(),
                                "quantity":
                                    controller.recipeBase[index].ingredients,
                                "instruction":
                                    controller.recipeBase[index].instructions,
                              });
                            },
                            image: "assets/images/898989.png",
                            name: controller.recipeBase[index].name,
                            cooktime: controller.recipeBase[index].mealTime
                                .toString(),
                          ),
                        );
                    }),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Text(
                  "More Filters",
                  style: TextStyle(
                    fontSize: 20,
                    color: AppColor.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              GetBuilder<ResultController>(
                init: ResultController(),
                builder: (controller) => Column(
                  children: [
                    FilteringRectangle(
                      check: controller.iconcheck1,
                      onpressed: () {
                        controller.iconchange1();
                      },
                      filtername: "Disease",
                    ),
                    if (controller.iconcheck1)
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: AppColor.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: controller.options.keys.map((option) {
                            return CheckboxListTile(
                              title: Text(option),
                              value: controller.options[option],
                              onChanged: (value) {
                                controller.toggleOption(option);
                              },
                              activeColor: AppColor.darkOrange,
                            );
                          }).toList(),
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              GetBuilder<ResultController>(
                init: ResultController(),
                builder: (controller) => Column(
                  children: [
                    FilteringRectangle(
                      check: controller.iconcheck2,
                      onpressed: () {
                        controller.iconchange2();
                      },
                      filtername: "Mealtime",
                    ),
                    if (controller.iconcheck2)
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: AppColor.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children:
                              controller.mealtimeOptions.keys.map((option) {
                            return RadioListTile(
                              title: Text(option),
                              value: option,
                              groupValue:
                                  controller.mealtimeOptions.keys.firstWhere(
                                (key) => controller.mealtimeOptions[key]!,
                                orElse: () => '',
                              ),
                              onChanged: (value) {
                                controller.toggleMealtimeOption(option);
                              },
                              activeColor: AppColor.darkOrange,
                            );
                          }).toList(),
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              GetBuilder<ResultController>(
                init: ResultController(),
                builder: (controller) => Column(
                  children: [
                    FilteringRectangle(
                      filtername: "Meal Duration",
                      onpressed: () async {
                        controller.iconchange3();
                        if (controller.iconcheck3) {
                          final duration = await showDurationPicker(
                            context: context,
                            initialTime: controller.selectedDuration,
                          );
                          if (duration != null) {
                            controller.updateDuration(duration);
                          }
                        }
                      },
                      check: controller.iconcheck3,
                    ),
                    if (controller.iconcheck3)
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: AppColor.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "Selected Duration: ${controller.selectedDuration.inMinutes} minutes",
                              style: TextStyle(color: AppColor.black),
                            ),
                          ],
                        ),
                      ),
                    SizedBox(height: 5),
                    GetBuilder<ResultController>(
                      builder: (controller) => Column(
                        children: [
                          FilteringRectangle(
                            filtername: "Nutrition Facts",
                            check: controller.iconcheck4,
                            onpressed: () {
                              controller.iconchange4();
                            },
                          ),
                          if (controller.iconcheck4)
                            Container(
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: AppColor.grey),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                children: [
                                  _buildSlider(
                                      controller,
                                      "Calories",
                                      controller.caloriesRange,
                                      1.1,
                                      1657.1, (newRange) {
                                    controller.updateCaloriesRange(newRange);
                                  }),
                                  _buildSlider(
                                      controller,
                                      "Carbohydrates (g)",
                                      controller.carbohydratesRange,
                                      0.1,
                                      246.0, (newRange) {
                                    controller
                                        .updateCarbohydratesRange(newRange);
                                  }),
                                  _buildSlider(
                                      controller,
                                      "Sugars (g)",
                                      controller.sugarsRange,
                                      0.0,
                                      125.7, (newRange) {
                                    controller.updateSugarsRange(newRange);
                                  }),
                                  _buildSlider(
                                      controller,
                                      "Fat (g)",
                                      controller.fatRange,
                                      0.0,
                                      153.3, (newRange) {
                                    controller.updateFatRange(newRange);
                                  }),
                                  _buildSlider(
                                      controller,
                                      "Saturated Fat (g)",
                                      controller.saturatedFatRange,
                                      0.0,
                                      81.7, (newRange) {
                                    controller
                                        .updateSaturatedFatRange(newRange);
                                  }),
                                  _buildSlider(
                                      controller,
                                      "Cholesterol (mg)",
                                      controller.cholesterolRange,
                                      0.0,
                                      1685.8, (newRange) {
                                    controller.updateCholesterolRange(newRange);
                                  }),
                                  _buildSlider(
                                      controller,
                                      "Protein (g)",
                                      controller.proteinRange,
                                      0.0,
                                      183.2, (newRange) {
                                    controller.updateProteinRange(newRange);
                                  }),
                                  _buildSlider(
                                      controller,
                                      "Dietary Fiber (g)",
                                      controller.dietaryFiberRange,
                                      0.0,
                                      26.0, (newRange) {
                                    controller
                                        .updateDietaryFiberRange(newRange);
                                  }),
                                  _buildSlider(
                                      controller,
                                      "Sodium (mg)",
                                      controller.sodiumRange,
                                      0.2,
                                      121298.3, (newRange) {
                                    controller.updateSodiumRange(newRange);
                                  }),
                                  _buildSlider(
                                      controller,
                                      "Calories from Fat",
                                      controller.caloriesFromFatRange,
                                      0.1,
                                      1379.7, (newRange) {
                                    controller
                                        .updateCaloriesFromFatRange(newRange);
                                  }),
                                  _buildSlider(
                                      controller,
                                      "Calcium (mg)",
                                      controller.calciumRange,
                                      0.1,
                                      1376.9, (newRange) {
                                    controller.updateCalciumRange(newRange);
                                  }),
                                  _buildSlider(
                                      controller,
                                      "Iron (mg)",
                                      controller.ironRange,
                                      0.0,
                                      54.6, (newRange) {
                                    controller.updateIronRange(newRange);
                                  }),
                                  _buildSlider(
                                      controller,
                                      "Magnesium (mg)",
                                      controller.magnesiumRange,
                                      0.1,
                                      425.3, (newRange) {
                                    controller.updateMagnesiumRange(newRange);
                                  }),
                                  _buildSlider(
                                      controller,
                                      "Potassium (mg)",
                                      controller.potassiumRange,
                                      0.5,
                                      3650.3, (newRange) {
                                    controller.updatePotassiumRange(newRange);
                                  }),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              GetBuilder<ResultController>(
                init: ResultController(),
                builder: (controller) => Column(
                  children: [
                    FilteringRectangle(
                      check: controller.iconcheck5,
                      onpressed: () {
                        controller.iconchange5();
                      },
                      filtername: "Dish Type",
                    ),
                    if (controller.iconcheck5)
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: AppColor.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children:
                              controller.dishtypeoption.keys.map((option) {
                            return CheckboxListTile(
                              title: Text(option),
                              value: controller.dishtypeoption[option],
                              onChanged: (value) {
                                controller.toggletypeOption(option);
                              },
                              activeColor: AppColor.darkOrange,
                            );
                          }).toList(),
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              GetBuilder<ResultController>(
                init: ResultController(),
                builder: (controller) => Column(
                  children: [
                    FilteringRectangle(
                      check: controller.iconcheck6,
                      onpressed: () {
                        controller.iconchange6();
                      },
                      filtername: "Dish Region",
                    ),
                    if (controller.iconcheck6)
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: AppColor.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children:
                              controller.dishRegionOption.keys.map((option) {
                            return CheckboxListTile(
                              title: Text(option),
                              value: controller.dishRegionOption[option],
                              onChanged: (value) {
                                controller.toggleRegionOption(option);
                              },
                              activeColor: AppColor.darkOrange,
                            );
                          }).toList(),
                        ),
                      ),
                  ],
                ),
              ),
              Row(
                children: [
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      // TODO: Implement the search functionality here
                    },
                    child: Container(
                      height: 35,
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColor.darkOrange,
                      ),
                      child: Center(
                        child: Text(
                          "filtering",
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
          ),
        ),
      ),
    );
  }

  Widget _buildSlider(
      ResultController controller,
      String label,
      RangeValues rangeValues,
      double min,
      double max,
      Function(RangeValues) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$label Range: ${rangeValues.start.toStringAsFixed(1)} - ${rangeValues.end.toStringAsFixed(1)}",
          style: TextStyle(color: AppColor.black),
        ),
        RangeSlider(
          values: rangeValues,
          min: min,
          max: max,
          divisions: 100,
          activeColor: AppColor.darkOrange,
          labels: RangeLabels(
            rangeValues.start.toStringAsFixed(1),
            rangeValues.end.toStringAsFixed(1),
          ),
          onChanged: onChanged,
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
