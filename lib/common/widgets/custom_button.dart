import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? color;
  final Color? textColor;
  final double? radius;
  final double? textSize;
  final double? height;
  final bool? enabled;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.color,
    this.textColor,
    this.radius = 45,
    this.textSize = 14.5,
    this.height = 46,
    this.enabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: enabled! ? onPressed : null,
      style: ElevatedButton.styleFrom(
        minimumSize:  Size(double.infinity, height!),
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius!),
        ),
        elevation: 1.0,
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor ?? AppColors.textColor,
          fontWeight: FontWeight.w400,
          fontSize: textSize,
        ),

      ),

    );
  }
}
