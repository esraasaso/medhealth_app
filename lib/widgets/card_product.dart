import 'package:flutter/material.dart';
import 'package:medhealth/theme.dart';
import 'package:intl/intl.dart';
class CardProduct extends StatelessWidget {
  final String imageProduct;
  final String nameProduct;
  final String price;
  CardProduct({
    required this.imageProduct,
    required this.nameProduct,
    required this.price,
  });
  @override
  Widget build(BuildContext context) {
    final priceFormat = NumberFormat("#,##0", "EN_US");
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Image.network(
            imageProduct,
            width: 115,
            height: 76,
          ),
          SizedBox(
            height: 16,
          ),
        Text(
           nameProduct,
        style: regulerTextstyle.copyWith(fontSize: 12,color: gryBoldColor),
            textAlign: TextAlign.center,
            maxLines: 3,
          ),
          SizedBox(
            height: 14,
          ),
          Text("LS " + priceFormat.format(int.parse(price)),
            style: regulerTextstyle.copyWith(fontSize: 15,color: gryBoldColor,overflow: TextOverflow.ellipsis),
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}
