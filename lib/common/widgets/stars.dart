import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../constants/app_colors.dart';

class Stars extends StatelessWidget {
  final double rating;
  final double itemSize;

  const Stars({
    Key? key,
    required this.rating,
    this.itemSize = 15.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
      direction: Axis.horizontal,
      rating: rating,
      itemCount: 5,
      itemSize: itemSize,
      unratedColor: Colors.black12,
      itemBuilder: (context, _) => const Icon(
        Icons.star,
        color: AppColors.secondaryColor,
      ),
    );
  }
}
