import 'dart:io';
import 'package:flutter/material.dart';
import 'package:medhealth/network/model/pref_profile_model.dart';
import 'package:medhealth/screens/login_screen.dart';
import 'package:medhealth/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
class ProfilePages extends StatefulWidget {
  @override
  _ProfilePagesState createState() => _ProfilePagesState();
}

class _ProfilePagesState extends State<ProfilePages> {
 late final String fullName, createdDate, phone, email, address;
  getPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      createdDate = sharedPreferences.getString(PrefProfile.created_at).toString();
    });
  }

  signOut() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove(PrefProfile.idUSer);
    sharedPreferences.remove(PrefProfile.name);
    sharedPreferences.remove(PrefProfile.email);
    sharedPreferences.remove(PrefProfile.phone);
    sharedPreferences.remove(PrefProfile.address);
    sharedPreferences.remove(PrefProfile.created_at);
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) =>LogIn()),
            (route) => false);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "My Profile",
                  style: regulerTextstyle.copyWith(fontSize: 25),
                ),
                InkWell(
                  onTap: () {
                    signOut();
                  },
                  child: Icon(
                    Icons.exit_to_app,
                    color: greenColor,
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                 "Esraa",
                  style: boldTextstyle.copyWith(fontSize: 18),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "Join at " + '2023-10-12',
                  style: lightTextStyle,
                )
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            color: whiteColor,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Phone",
                  style: lightTextStyle,
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                 ' 099864750',
                  style: boldTextstyle.copyWith(fontSize: 18),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Email",
                  style: lightTextStyle,
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                'israa@hotmail.com',
                  style: boldTextstyle.copyWith(fontSize: 18),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            color: whiteColor,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Address",
                  style: lightTextStyle,
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  'Baramkeh',
                  style: boldTextstyle.copyWith(fontSize: 18),
                ),
                SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
