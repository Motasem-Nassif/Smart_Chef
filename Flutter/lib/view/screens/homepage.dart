/*import 'package:flutter/material.dart';
import 'package:smartchef/core/constants/appcolors.dart';
import 'package:smartchef/view/widgets/dishcardwidget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Padding(
        padding:
            const EdgeInsets.only(top: 50, right: 10, left: 10, bottom: 70),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200,
                child: Stack(
                  children: [
                    Positioned(
                      top: 30,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 150,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColor.orange,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            " Welcome in SmartChef\n App you're daily recipes\n helper let A.I help you",
                            style: TextStyle(
                                height: 1.7,
                                color: Colors.white,
                                fontSize: 19,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: -15,
                      right: -50,
                      child: Image.asset(
                        "assets/images/chef2.png",
                        height: 200,
                        width: 200,
                      ),
                    ),
                  ],
                ),
              ),
              TabBar(
                labelColor: AppColor.darkOrange,
                indicatorColor: AppColor.darkOrange,
                isScrollable: true,
                tabs: [
                  Container(
                    //    width: 100,
                    child: Tab(
                      text: "Breakfast",
                      icon: Image.asset(
                        "assets/images/breakfast.png",
                        height: 35,
                        width: 35,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Tab(
                    text: "Lunch",
                    icon: Image.asset(
                      "assets/images/meal.png",
                      height: 35,
                      width: 35,
                    ),
                  ),
                  Tab(
                    text: "Dinner",
                    icon: Image.asset("assets/images/dinner.png",
                        height: 35, width: 35),
                  ),
                  Tab(
                    text: "Dessert",
                    icon: Image.asset(
                      "assets/images/frozen.png",
                      height: 35,
                      width: 35,
                    ),
                  ),
                  Tab(
                    text: 'snack',
                    icon: Image.asset(
                      "assets/images/snack.png",
                      height: 35,
                      width: 35,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 200, // Set a fixed height for the TabBarView
                child: TabBarView(children: [
                  Container(
                    height: 200,
                    width: double.infinity,
                    //    color: Colors.blue,
                    child: ListView.separated(
                        //     shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => DishCardWidget(
                            cooktime: "30min",
                            image: "assets/images/breakfast.png",
                            name: "Kebsa"),
                        separatorBuilder: (contex, index) => SizedBox(
                              width: 5,
                            ),
                        itemCount: 10),
                  ),
                  Container(
                    height: 200,
                    width: double.infinity,
                    //    color: Colors.blue,
                    child: ListView.separated(
                        //     shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => DishCardWidget(
                            cooktime: "30min",
                            image: "assets/images/meal.png",
                            name: "Kebsa"),
                        separatorBuilder: (contex, index) => SizedBox(
                              width: 5,
                            ),
                        itemCount: 10),
                  ),
                  Container(
                    height: 200,
                    width: double.infinity,
                    //    color: Colors.blue,
                    child: ListView.separated(
                        //     shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => DishCardWidget(
                            cooktime: "30min",
                            image: "assets/images/dinner.png",
                            name: "Kebsa"),
                        separatorBuilder: (contex, index) => SizedBox(
                              width: 5,
                            ),
                        itemCount: 10),
                  ),
                  Container(
                    height: 200,
                    width: double.infinity,
                    //    color: Colors.blue,
                    child: ListView.separated(
                        //     shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => DishCardWidget(
                            cooktime: "30min",
                            image: "assets/images/frozen.png",
                            name: "Kebsa"),
                        separatorBuilder: (contex, index) => SizedBox(
                              width: 5,
                            ),
                        itemCount: 10),
                  ),
                  Container(
                    height: 200,
                    width: double.infinity,
                    //    color: Colors.blue,
                    child: ListView.separated(
                        //     shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => DishCardWidget(
                            function: () {},
                            cooktime: "30min",
                            image: "assets/images/snack.png",
                            name: "Kebsa"),
                        separatorBuilder: (contex, index) => SizedBox(
                              width: 5,
                            ),
                        itemCount: 10),
                  ),
                ]),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Text(
                  "Dishes fit with diabetes",
                  style: TextStyle(
                      fontSize: 20,
                      color: AppColor.grey,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 200,
                width: double.infinity,
                //    color: Colors.blue,
                child: ListView.separated(
                    //     shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => DishCardWidget(
                        cooktime: "30min",
                        image: "assets/images/kebsa.png",
                        name: "Kebsa"),
                    separatorBuilder: (contex, index) => SizedBox(
                          width: 5,
                        ),
                    itemCount: 10),
              )
            ],
          ),
        ),
      ),
    );
  }
}
*/