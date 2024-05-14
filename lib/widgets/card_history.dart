import 'package:flutter/material.dart';
import 'package:medhealth/theme.dart';

import '/network/model/history_model.dart';

class CardHistory extends StatelessWidget {
  final HistoryOrdelModel model;
  CardHistory({required this.model});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text("INV/" + model.invoice,style: boldTextstyle.copyWith(fontSize: 16),),
            Icon(Icons.arrow_forward_ios,size: 14,)],
        ),
        Text(model.orderAt,style: regulerTextstyle.copyWith(fontSize: 16),),
        SizedBox(
          height: 12,
        ),
        Text( model.status == "1"
            ? "Order is being confirmed"
            : "Order completed",
          style: lightTextStyle,),
        Divider()
      ],
    );
  }
}
