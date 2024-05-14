import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medhealth/main_page.dart';
import 'package:medhealth/screens/home.dart';
import 'package:medhealth/screens/local.dart';
import 'package:medhealth/screens/local_controlar.dart';
import 'package:medhealth/screens/localization.dart';
import 'package:medhealth/screens/payment.dart';
import 'package:medhealth/screens/splash_screen.dart';
import 'package:medhealth/theme.dart';
import 'screens/first_screen.dart';
import 'maps.dart';
void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(MyController());
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: greenColor,
            elevatedButtonTheme: ElevatedButtonThemeData(style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(greenColor)))
        ),
        locale: Get.deviceLocale,
        translations: MyLocal(),
        routes:{
          '/':(context) =>First(),
          // LogIn.routeName :(context) =>LogIn(),
        }
    );
  }
}
