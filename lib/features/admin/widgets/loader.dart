import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';

class Loader extends StatelessWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const LinearProgressIndicator(
      backgroundColor: Colors.red,
      color: AppColors.secondaryColor,
    );
  }
}
