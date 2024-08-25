import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:smartchef/binding/bindings.dart';
import 'package:smartchef/core/constants/appcolors.dart';
import 'package:smartchef/services.dart';
import 'package:smartchef/view/screens/mainscreen.dart';
import 'package:smartchef/view/screens/register.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await initialServices();
  
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Material(
      child: Center(
        child: Text(
          details.exception.toString(),
          style: TextStyle(color: Colors.red, fontSize: 18),
        ),
      ),
    );
  };
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
       initialBinding: InitialBindings(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColor.lightOrange,
        hintColor: AppColor.darkOrange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: AppBarTheme(
          color: AppColor.darkOrange,
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.orange,
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      home: RegisterUserScreen(),
    );
  }
}
