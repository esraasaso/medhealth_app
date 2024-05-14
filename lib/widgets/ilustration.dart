import 'package:flutter/material.dart';
import 'package:medhealth/theme.dart';
class Ilustration extends StatelessWidget {
final Widget child;
final String title;
final String title2;
final String image;
final String subtitle1;
final String subtitle2;
 Ilustration(this.image, this.title,this.title2, this.subtitle1, this.subtitle2,this.child,);
  @override
  Widget build(BuildContext context) {
    return Column(

      children: [
        const SizedBox(
          height: 30,
        ),
        Image.asset(image, width: 280,fit: BoxFit.cover,),
        const SizedBox(
          height: 50,
        ),
        Text(title, style: regulerTextstyle.copyWith(fontSize: 25),
          textAlign: TextAlign.center,),
        Text(title2, style: regulerTextstyle.copyWith(fontSize: 25),
          textAlign: TextAlign.center,),
        const SizedBox(
          height: 16,
        ),
        Column(
          children: [
            Text(subtitle1, style: regulerTextstyle.copyWith(
                fontSize: 15, color: gryLightColor),),
            Text(subtitle2, style: regulerTextstyle.copyWith(
                fontSize: 15, color: gryLightColor),),
            const SizedBox(
              height:110,
            ),
            child,
          ],
        )
      ],
    );
  }}