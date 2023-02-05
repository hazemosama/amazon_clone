import 'package:flutter/material.dart';

enum CartButton2Position { right, left }

class CartButton2 extends StatelessWidget {
  final IconData icon;
  final CartButton2Position position;
  final VoidCallback onPressed;

  const CartButton2({
    Key? key,
    required this.icon,
    required this.position, required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 43,
      height: 37.5,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.teal,
          fixedSize: const Size(0, 37.5),
          backgroundColor: const Color(0x6FE3E1E1),
          shape: RoundedRectangleBorder(
              borderRadius: position == CartButton2Position.right
                  ? const BorderRadius.horizontal(right: Radius.circular(8))
                  : const BorderRadius.horizontal(left: Radius.circular(8))),
          padding: const EdgeInsets.all(0),
        ),
        child: Icon(
          icon,
          color: Colors.black,
          size: 18,
        ),
      ),
    );
  }
}
