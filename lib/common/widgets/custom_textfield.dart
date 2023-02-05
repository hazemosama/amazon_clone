import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int maxLines;
  final double radius;
  final bool? enabled;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.maxLines = 1,
    this.radius = 20,
    this.enabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: enabled! ? Colors.white : const Color(0xffd3d3d3),
        enabled: enabled!,
        hintText: hintText,
        border:  OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.black38,
          ),
          borderRadius: BorderRadius.circular(radius)
        ),
        enabledBorder:  OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.black38,
          ), borderRadius: BorderRadius.circular(radius)
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 17, horizontal: 13),
      ),
      style: const TextStyle(color: Color(0xff6f7373)),
      validator: (val) {
        if (val == null || val.isEmpty) {
          return "Enter your $hintText";
        }
        return null;
      },
      maxLines: maxLines,
    );
  }
}
