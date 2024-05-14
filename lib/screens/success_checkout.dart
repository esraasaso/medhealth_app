import 'package:flutter/material.dart';
import 'package:medhealth/main_page.dart';
import 'package:medhealth/widgets/button_primary.dart';
import 'package:medhealth/widgets/general_logo_space.dart';
import 'package:medhealth/widgets/ilustration.dart';

class SuccessCheckOut extends StatelessWidget {
  const SuccessCheckOut({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GeneralLogoSpace(
          child: Column(
            children: [
              SizedBox(
                height:80,
              ),
              Ilustration(
                "assets/order_success_ilustration.png",
                "Yeayy,your order was ",
                    "Successfully",
                "consult with a doctor",
                "wherever and whenever you want",
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical:0,horizontal: 50),
                  child: ButtonPrimary(
                    "BACK TO HOME",
                        () {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainPages()));
                    },
                  ),
                ),
              )
            ],
          )),
    );
  }
}
