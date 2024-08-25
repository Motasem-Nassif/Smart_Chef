/*import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartchef/controller/searchcontroller.dart';
import 'package:smartchef/core/constants/appcolors.dart';
import 'package:smartchef/view/widgets/labelborder.dart';

class IngredientInputForm extends StatelessWidget {
  const IngredientInputForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Search1Controller controller = Get.find<Search1Controller>();

    return Form(
      key: controller.formstate,
      child: Row(
        children: [
          Expanded(
            child: LabelOnBorder(
              label: "input form",
              height: 250,
              width: 250,
              borderRadius: 15,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextFormField(
                      controller: controller.quantitycontroller,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "quantity",
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "You must enter a quantity";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    DropdownButtonFormField<String>(
                      value: controller.selectedcurrently,
                      decoration: InputDecoration(
                        labelText: 'unit',
                      ),
                      items: [
                        DropdownMenuItem(value: "gram", child: Text('gram')),
                        DropdownMenuItem(
                            value: "kilogram", child: Text('kilogram')),
                        DropdownMenuItem(
                            value: "milligram", child: Text('milligram')),
                        DropdownMenuItem(value: "liter", child: Text('liter')),
                        DropdownMenuItem(
                            value: "milliliter", child: Text('milliliter')),
                        DropdownMenuItem(value: "cup", child: Text('cup')),
                        DropdownMenuItem(
                            value: "tablespoon", child: Text('tablespoon')),
                        DropdownMenuItem(
                            value: "teaspoon", child: Text('teaspoon')),
                        DropdownMenuItem(value: "ounce", child: Text('ounce')),
                        DropdownMenuItem(value: "pound", child: Text('pound')),
                        DropdownMenuItem(value: "quart", child: Text('quart')),
                        DropdownMenuItem(
                            value: "gallon", child: Text('gallon')),
                        DropdownMenuItem(value: "pinch", child: Text('pinch')),
                        DropdownMenuItem(value: "dash", child: Text('dash')),
                      ],
                      onChanged: (value) {
                        controller.selectedcurrently = value;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "You must choose a unit";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: controller.ingerdiantcontroller,
                      decoration: InputDecoration(labelText: "ingredient"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "You must enter an ingredient";
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          Column(
            children: [
              GestureDetector(
                onTap: controller.onsubmit,
                child: CircleAvatar(
                  minRadius: 28,
                  backgroundColor: AppColor.darkOrange,
                  child: Icon(
                    Icons.check,
                    size: 40,
                    color: AppColor.white,
                  ),
                ),
              ),
              SizedBox(height: 10),
              GetBuilder<Search1Controller>(
                builder: (controller) {
                  return controller.showDoneButton && !controller.showContainer
                      ? GestureDetector(
                          onTap: controller.onDone,
                          child: CircleAvatar(
                            minRadius: 28,
                            backgroundColor: AppColor.darkOrange,
                            child: Text(
                              "Done",
                              style: TextStyle(
                                color: AppColor.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        )
                      : Container();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
*/