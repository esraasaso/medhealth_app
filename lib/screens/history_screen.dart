import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:medhealth/network/api/url_api.dart';
import 'package:medhealth/theme.dart';
import '../network/model/history_model.dart';
import '/network/model/pref_profile_model.dart';
import '/widgets/card_history.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/widgets/ilustration.dart';

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryPagesState createState() => _HistoryPagesState();
}

class _HistoryPagesState extends State<HistoryScreen> {
  List<HistoryOrdelModel> list = [];
  late String userID;
  getPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      userID = sharedPreferences.getString(PrefProfile.idUSer).toString();
    });
    getHistory();
  }

  getHistory() async {
    list.clear();
    var urlHistory = Uri.parse(Personal.historyOrder + userID);
    final response = await http.get(urlHistory);
    if (response.statusCode == 200) {
      setState(() {
        final data = jsonDecode(response.body);
        for (Map<String,dynamic> item in data) {
          list.add(HistoryOrdelModel.fromJson(item));
        }
        print(list[0].idUser);
      });
    }
  }


  @override
  void initState() {
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(children: [
          Container(
              padding: EdgeInsets.fromLTRB(24, 24, 24, 0),
              height: 70,
              child: Text(
                "History Order",
                style: regulerTextstyle.copyWith(fontSize: 25),
              )),
          SizedBox(
            height: (list.length == 0) ? 80 : 20,
          ),
          list.length == 0
              ? Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Ilustration(
                    "assets/no_history_ilustration.png",
                    "You dont have history order",
                     "lets shopping now",
                     "Oops, there are no history order",
                      "",
                      Container(),
                    ),
                  ),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: list.length,
                  itemBuilder: (context, i) {
                    final x = list[i];
                    return Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                      child: CardHistory(
                       model: x,
                      ),
                    );
                  }),
        ]),
      ),
    );
  }
}
