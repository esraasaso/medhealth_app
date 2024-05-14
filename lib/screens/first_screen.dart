
import 'package:flutter/material.dart';
import 'package:medhealth/screens/splash_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

class First extends StatefulWidget {
  const First({super.key});

  @override
  State<First> createState() => _FirstState();
}

class _FirstState extends State<First> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
    body:Expanded(
      child: ListView(
          shrinkWrap:true,
       children: [
      Padding(padding:EdgeInsets.only(top:250),
          child: Lottie.asset('assets/Animation.json')),
          AnimatedSplashScreen(
          duration: 5000,
          splash: Icons.home,
          nextScreen: SplashScreen(),
          splashTransition: SplashTransition.fadeTransition,
          backgroundColor: Colors.blue),
      ],
      ),
    ));
  }
}
