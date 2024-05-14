import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medhealth/network/api/url_api.dart';
import 'package:medhealth/screens/payment.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/network/model/cart_model.dart';
import '/widgets/button_primary.dart';
import '/network/model/pref_profile_model.dart';
import 'cart.dart';
import 'success_checkout.dart';
import 'package:http/http.dart'as http;
import 'package:medhealth/theme.dart';

class CartPage extends StatefulWidget {
final VoidCallback method;
CartPage (this.method);
  @override
  State<CartPage> createState() => _CartPageState();
}
class _CartPageState extends State<CartPage> {
  final price = NumberFormat("#,##0", "EN_US");
  late String userID, fullName, address, phone;
  int delivery = 0;
  getPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      userID = sharedPreferences.getString(PrefProfile.idUSer).toString();
      fullName = sharedPreferences.getString(PrefProfile.name).toString();
      address = sharedPreferences.getString(PrefProfile.address).toString();
      phone = sharedPreferences.getString(PrefProfile.phone).toString();
    });
    getCart();
    cartTotalPrice();
  }
int value=6000;
  List<CartModel> listCart = [];

    getCart() async {
    listCart.clear();
    var urlGetCart = Uri.parse(Personal.getProductCart + userID);
    final response = await http.get(urlGetCart);
    if (response.statusCode == 200) {
      setState(() {
        final data = jsonDecode(response.body);
        for (Map item in data) {
          listCart.add(CartModel.fromJson(item));
        }
      });
      print(listCart[0].name);
    }
  }

  updateQuantity(String type, String model) async {
    var urlUpdateQuantity = Uri.parse(Personal.updateQuantityProductCart);
    final response = await http.post(urlUpdateQuantity, body: {"cartID": model, "type": type});
    final data = jsonDecode(response.body);
    int value = data['value'];
    String message = data['message'];
    if (value == 1) {
      print(message);
      setState(() {
        getPref();
     widget.method;
      });
    } else {
      print(message);
      setState(() {
        getPref();
        widget.method;
      });
    }
  }

  checkout() async {
    var urlCheckout = Uri.parse(Personal.checkout);
    final response = await http.post(urlCheckout, body: {
      "idUser": userID,
    });
    final data = jsonDecode(response.body);
    int value = data['value'];
    String message = data['message'];
    if (value == 1) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) =>Payment()),
              (route) => false);
    } else {
      print(message);
    }
  }

  var sumPrice = "0";
  int totalPayment = 0;
  cartTotalPrice() async {
    var urlTotalPrice = Uri.parse(Personal.totalPriceCart + userID);
    final response = await http.get(urlTotalPrice);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      String total = data['Total'];
      setState(() {
        sumPrice = total;
        totalPayment = sumPrice == null ? 0 : int.parse(sumPrice) + delivery;
      });
      print(sumPrice);
    }
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    getPref();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: listCart.length == 0
          ? SizedBox()
          : Container(
        padding: EdgeInsets.all(24),
        height: 225,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Color(0xfffcfcfc),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30))),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total Items",
                  style: regulerTextstyle.copyWith(
                      fontSize: 16, color:gryBoldColor),
                ),
                Text(
                  "LS " + price.format(int.parse(sumPrice)),
                  style:boldTextstyle.copyWith(fontSize: 16),
                ),
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Delivery Fee",
                  style: regulerTextstyle.copyWith(
                      fontSize: 16, color: gryBoldColor),
                ),
                Text(
                  // delivery == 6000 ?
                  "6000",
                    // delivery.toString(),
                  style: boldTextstyle.copyWith(fontSize: 16),
                ),
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total Payment",
                  style: regulerTextstyle.copyWith(
                      fontSize: 16, color: gryBoldColor),
                ),
                Text(
                  "LS " + price.format(totalPayment),
                  style: boldTextstyle.copyWith(fontSize: 16),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: ButtonPrimary(
                "CHECKOUT NOW",
                () {
                  checkout();
                },
              ),
            )
          ],
        ),
      ),
      body: SafeArea(
          child: ListView(
            padding: EdgeInsets.only(bottom: 220),
            children: [
              Container(
                  padding: EdgeInsets.fromLTRB(24, 24, 24, 0),
                  height: 70,
                  child: Row(children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back_rounded,
                        size: 32,
                        color: greenColor,
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Text(
                      "My Cart",
                      style: regulerTextstyle.copyWith(fontSize: 25),
                    )
                  ])),
              listCart.length == 0 ? Cart()
                  : Container(
                padding: EdgeInsets.all(24),
                height: 180,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Delivery Destination",
                      style: regulerTextstyle.copyWith(fontSize: 18),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Name",
                          style: regulerTextstyle.copyWith(
                              fontSize: 16, color: gryBoldColor),
                        ),
                        Text(
                          "$fullName",
                          style: boldTextstyle.copyWith(fontSize: 16),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Address",
                          style: regulerTextstyle.copyWith(
                              fontSize: 16, color: gryBoldColor),
                        ),
                        Text(
                          "$address",
                          style: boldTextstyle.copyWith(fontSize: 16),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Phone",
                          style: regulerTextstyle.copyWith(
                              fontSize: 16, color: gryBoldColor),
                        ),
                        Text(
                          "$phone",
                          style: boldTextstyle.copyWith(fontSize: 15),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              ListView.builder(
                  itemCount: listCart.length,
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemBuilder: (context, i) {
                    final x = listCart[i];
                    return Container(
                      padding: EdgeInsets.all(24),
                      color: whiteColor,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.network(
                                x.image,
                                width: 115,
                                height: 100,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width - 200,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      x.name,
                                      style:
                                      regulerTextstyle.copyWith(fontSize: 16),
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                            icon: Icon(
                                              Icons.add_circle,
                                              color: greenColor,
                                            ),
                                            onPressed: () {
                                              updateQuantity("add", x.idCart);
                                            }),
                                        Text(x.quantity),
                                        IconButton(
                                            icon: Icon(
                                              Icons.remove_circle,
                                              color: Color(0xfff0997a),
                                            ),
                                            onPressed: () {
                                              updateQuantity("kurang", x.idCart);
                                            }),
                                      ],
                                    ),
                                    Text(
                                      "LS " + price.format(int.parse(x.price)),
                                      style: boldTextstyle.copyWith(fontSize: 16),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Divider()
                        ],
                      ),
                    );
                  })
            ],
          )),
    );
  }
}
