import 'package:get/get.dart';
class MyLocal implements Translations
{
  @override
  Map<String, Map<String, String>> get keys => {
    "ar": {"1" : "يمكنك تغيير اللغة",
      "2":"العربية",
      "3":"الانجليزية"},
    "en": {"1" : "Change your Language",
      "2":"ARABIC",
      "3":"ENGLISH"}
  };
}