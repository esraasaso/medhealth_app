import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medhealth/screens/local_controlar.dart';
import 'package:medhealth/screens/register_screen.dart';
import '/widgets/button_primary.dart';
import '/theme.dart';
import '/widgets/general_logo_space.dart';
class LocalizationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MyController controllerLanguage = Get.find();
    return Scaffold(
          body: ListView(
            children: [
              Container(
                child: GeneralLogoSpace(child: Container(),),
              ),
              Container(
                padding: EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 250,
                    ),
                    Text(
                      "1".tr,
                      style: boldTextstyle.copyWith(fontSize: 25),textAlign: TextAlign.center
                      ,
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    Container(
                      child: ButtonPrimary(
                        "2".tr,
                            () {
                          controllerLanguage.Changelanguage("ar");
                        },
                      ),
                    ),

                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      child: ButtonPrimary(
                        "3".tr,
                            () {
                              controllerLanguage.Changelanguage("en");
                        },
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      child:IconButton(onPressed:(){
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterScreen()),
                                (route) => false);
                      },

                        icon: Icon(Icons.arrow_forward_ios),
                      color: gryLightColor,)
                      ),
                  ],
                ),
              )
            ],
          ),
    );
  }
}
