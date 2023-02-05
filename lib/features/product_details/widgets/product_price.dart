import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProductPrice extends StatelessWidget {
  ProductPrice({
    Key? key,
    required this.price,
    this.bold = false,
    this.isSearch,
    required this.textSize,
    required this.subTextSize,
  }) : super(key: key);

  final double price;
  final NumberFormat formatter = NumberFormat('###,###');
  final bool? isSearch;
  final bool? bold;
  final double textSize;
  final double subTextSize;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.horizontal,
      children: [
        Text(
          'EGP',
          style: TextStyle(
            fontSize: subTextSize,
            fontFeatures: const [FontFeature.superscripts()],
            fontWeight: bold! ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          formatter.format(price.round()),
          style: TextStyle(
            fontSize: textSize,
            fontWeight: bold! ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          price
              .toStringAsFixed(2)
              .substring(price.toStringAsFixed(2).indexOf('.') + 1),
          style: TextStyle(
            fontSize: subTextSize,
            fontWeight: bold ! ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
