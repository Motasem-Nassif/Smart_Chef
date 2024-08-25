import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartchef/controller/dishdetailscontroller.dart';
import 'package:smartchef/core/constants/appcolors.dart';
import 'package:smartchef/data/staticdata.dart';

class DishDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final DishDetailController controller = Get.put(DishDetailController());

    return Scaffold(
      body: NotificationListener<ScrollNotification>(
        onNotification: (scrollNotification) {
          if (scrollNotification is ScrollUpdateNotification) {
            double delta = scrollNotification.scrollDelta ?? 0.0;
            controller.updateContainerHeight(
                delta * 0.0005); // Adjusting scroll sensitivity
          }
          return true;
        },
        child: GetBuilder<DishDetailController>(
          builder: (controller) {
            return CustomScrollView(
              slivers: [
                SliverPersistentHeader(
                  delegate: MySliverAppBar(
                    expandedHeight: MediaQuery.of(context).size.height *
                        controller.firstContainerHeightPercentage,
                  ),
                  pinned: true,
                ),
                SliverToBoxAdapter(
                  child: Container(
                    height: MediaQuery.of(context).size.height *
                        controller.secondContainerHeightPercentage,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  "Kebsa",
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      "Calories",
                                      style: TextStyle(
                                        color: AppColor.grey,
                                      ),
                                    ),
                                    SizedBox(height: 2),
                                    Text(
                                      "150 Kcal",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: AppColor.black,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 25,
                                  width: 2,
                                  color: AppColor.grey,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      "Fat",
                                      style: TextStyle(
                                        color: AppColor.grey,
                                      ),
                                    ),
                                    SizedBox(height: 2),
                                    Text(
                                      "20%",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: AppColor.black,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 25,
                                  width: 2,
                                  color: AppColor.grey,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      "Protein",
                                      style: TextStyle(
                                        color: AppColor.grey,
                                      ),
                                    ),
                                    SizedBox(height: 2),
                                    Text(
                                      "500 mg ",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: AppColor.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Ingredients",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                          GetBuilder<DishDetailController>(
                            builder: (controller) {
                              return Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: List.generate(
                                              StaticData
                                                  .kebsaIngredients.length,
                                              (index) => Text(
                                                  StaticData.kebsaIngredients[
                                                          index]["amount"].toString() +
                                                      ' ' +
                                                      StaticData.kebsaIngredients[
                                                          index]["unit"])),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: List.generate(
                                              StaticData
                                                  .kebsaIngredients.length,
                                              (index) => Text(StaticData
                                                      .kebsaIngredients[index]
                                                  ["ingredient"])),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Recipe Preparation",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Following this, add chopped tomatoes and grated carrots to the pot. Stir well and cook until the tomatoes are soft and the mixture thickens into a sauce-like consistency. Stir in the tomato paste and cook for a few more minutes. Afterward, add salt, black pepper, cumin, coriander, cinnamon sticks, cardamom pods, cloves, and bay leaves to the pot, mixing well to ensure the spices are evenly distributed.\n\n"
                              "Return the browned chicken pieces to the pot and add the rice, stirring to combine it with the chicken and vegetable mixture. Pour in the chicken broth, ensuring the rice and chicken are fully submerged. Bring the mixture to a boil, then reduce the heat to low and cover the pot. Let it simmer gently until the rice is tender and has absorbed all the liquid, which typically takes around 30-40 minutes. Stir occasionally to prevent the rice from sticking to the bottom of the pot.\n\n"
                              "Once the rice is cooked and the chicken is tender, remove the pot from the heat. Fluff the rice with a fork and ensure the spices are well mixed. Serve the Kebsa hot, garnished with roasted nuts or fresh herbs if desired. Enjoy your delicious, aromatic Kebsa!",
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;

  MySliverAppBar({required this.expandedHeight});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    double containerHeight = expandedHeight - shrinkOffset > kToolbarHeight
        ? expandedHeight - shrinkOffset
        : kToolbarHeight;

    return Padding(
      padding: EdgeInsets.only(top: 30),
      child: Container(
        height: containerHeight,
        width: MediaQuery.of(context).size.width,
        color: AppColor.lightGrey,
      ),
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
