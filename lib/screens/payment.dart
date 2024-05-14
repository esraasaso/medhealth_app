import 'package:flutter/material.dart';
import 'package:medhealth/screens/success_checkout.dart';
import 'package:medhealth/theme.dart';
import '../main_page.dart';
import '../widgets/general_logo_space.dart';
import '/widgets/button_primary.dart';

class Payment extends StatefulWidget {
  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  int value = 0;
  final paymentLabels = [
    'Credit card / Debit card',
    'Cash on delivery',
    'Paypal',
    'Health Insurance',
  ];
  final paymentIcons = [
    Icons.credit_card,
    Icons.money_off,
    Icons.payment,
    Icons.account_balance_wallet,
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: GeneralLogoSpace(child: Container(),),
            ),
            SizedBox(
              height: 180,
            ),
            Text(
         ' Choose Your Payment Method', style: regulerTextstyle.copyWith(fontSize: 25),),
            SizedBox(
              height:35,
            ),
            Expanded(
              child: ListView.separated(
                itemCount: paymentLabels.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Radio(
                      activeColor:greenColor,
                      value: index,
                      groupValue: value,
                      onChanged: (i) => setState(() => value = index),
                    ),
                    title: Text(
                      paymentLabels[index],
                       style: boldTextstyle.copyWith(fontSize: 18),
                    ),
                    trailing: Icon(paymentIcons[index], color:greenColor),
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider();
                },
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical:60,horizontal: 50),
              width: MediaQuery.of(context).size.width,
              child: ButtonPrimary(
                "PAY",
                    () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>SuccessCheckOut()));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
