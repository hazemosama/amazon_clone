import 'package:flutter/material.dart';

class ScreenDivider extends StatelessWidget {
  final EdgeInsetsGeometry? margin;
  const ScreenDivider({
    Key? key,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      color: Colors.black12,
      height: 5,
    );
  }
}