import 'package:flutter/material.dart';

import 'package:medhealth/theme.dart';

class CardCategory extends StatelessWidget {
  final imageCategory;
  final nameCategory;

  CardCategory({
    required this.imageCategory,
    required this.nameCategory,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          imageCategory,
          width: 60,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          nameCategory,
        style: boldTextstyle.copyWith(fontSize:10,color:gryBoldColor,overflow: TextOverflow.visible),
          maxLines: 2,
        ),
      ],
    );
  }
}
