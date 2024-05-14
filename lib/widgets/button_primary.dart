import 'package:flutter/material.dart';
import 'package:medhealth/theme.dart';
class ButtonPrimary extends StatelessWidget {
final String text;
final Function onTap;
ButtonPrimary(this.text,this.onTap);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 100,
      height:50,
      child: ElevatedButton(onPressed:(){onTap();}
      ,style:ElevatedButton.styleFrom(foregroundColor:whiteColor,shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
      child: Text(text,style: regulerTextstyle.copyWith(fontSize: 20,color: whiteColor),),),
    );
  }
}
