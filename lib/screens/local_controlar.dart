import 'dart:ui';

import 'package:get/get.dart';

class  MyController extends   GetxController{
  void Changelanguage (String codeLang)
  {
    Locale locale =Locale(codeLang);
    Get.updateLocale(locale);
  }
}