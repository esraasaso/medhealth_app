import 'package:flutter/material.dart';
import 'package:medhealth/maps.dart';
import 'package:medhealth/screens/localization.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/network/model/pref_profile_model.dart';
import '/main_page.dart';
import 'register_screen.dart';
import 'package:medhealth/widgets/button_primary.dart';
import 'package:medhealth/widgets/ilustration.dart';
import 'package:medhealth/widgets/general_logo_space.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  static String routeName = "splashscreen";
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  late String userID;
  getPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      userID = sharedPreferences.getString(PrefProfile.idUSer).toString();
      userID == null ? sessionLogout : sessionLogin;
    });
  }
  sessionLogout() {}
  sessionLogin() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LogIn()));
  }


  @override
  void initState() {
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GeneralLogoSpace(
          child: Column(
            children: [
              const SizedBox(
                height:80,
              ),
              Ilustration(
                "assets/splash_ilustration.png",
                "Find your medical",
                "solution",
                "consult with a doctor",
                "wherever and whenever you want",
                ButtonPrimary(
                    "Get Started",
                    (){Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LocalizationScreen()));}
                ),
              )
            ],
          )),
    );
  }
}
