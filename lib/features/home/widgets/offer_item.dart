import 'package:flutter/material.dart';

class OfferItem extends StatelessWidget {
  final String title;
  final String imageUrl;

  const OfferItem({
    Key? key,
    required this.title,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 138,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        children: [
           Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          Container(
            height: 152,
            decoration:  BoxDecoration(
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(5),
              ),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  imageUrl,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
