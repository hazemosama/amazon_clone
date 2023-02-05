import 'package:amazon_clone/features/account/widgets/account_button.dart';
import 'package:flutter/material.dart';

class TopAccButtons extends StatefulWidget {
  const TopAccButtons({Key? key}) : super(key: key);

  @override
  State<TopAccButtons> createState() => _TopAccButtonsState();
}

class _TopAccButtonsState extends State<TopAccButtons> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            AccountButton(
              text: 'Your Orders',
              onPressed: () {},
            ),
            AccountButton(
              text: 'Turn Seller',
              onPressed: () {},
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            AccountButton(
              text: 'Log Out',
              onPressed: () {},
            ),
            AccountButton(
              text: 'Your Wish List',
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }
}
