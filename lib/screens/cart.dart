import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '/main_page.dart';
import '/widgets/button_primary.dart';
import '/widgets/ilustration.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        margin: EdgeInsets.only(top: 20),
        child: Ilustration(
          "assets/empty_cart_ilustration.png",
          "Oops, there are no products in your cart",
          "Your cart is still empty, browse the",
          "attractive products from MEDHEALTH",
          "",
          Container(
            margin: EdgeInsets.only(top: 15),
            width: MediaQuery.of(context).size.width,
            child: ButtonPrimary(
              "SHOPPING NOW",
                  () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MainPages()),
                        (route) => false);
              },
            ),
          ),
        ),
      );
    }
  }

