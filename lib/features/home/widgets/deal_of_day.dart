import 'package:flutter/material.dart';

class TodayDeals extends StatelessWidget {
  const TodayDeals({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(left: 10, top: 15),
          child: const Text(
            "Today's Deals",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Image.network(
          'https://m.media-amazon.com/images/I/71jG+e7roXL._AC_SL1500_.jpg',
          height: 235.0,
          fit: BoxFit.fitHeight,
        ),
        const SizedBox(
          height: 8.0,
        ),
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(left: 15),
          child: const Text(
            'EGP 35,400',
            style: TextStyle(fontSize: 18.0),
          ),
        ),
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(left: 15, top: 5, right: 40),
          child: const Text(
            'Apple Macbook Air 2020 Model, (13-Inch, Apple M1 chip with 8-core CPU and 7-core GPU, 8GB, 256GB, MGN63), Eng-KB, Space Gray',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.network(
                'https://www.notebookcheck.net/uploads/tx_nbc2/2020-12-07_00_20_10-13__MacBook_Pro_kaufen_-_Apple__DE_.png',
                fit: BoxFit.fitWidth,
                width: 100.0,
                height: 100.0,
              ),
              Image.network(
                'https://9to5mac.com/wp-content/uploads/sites/6/2020/11/Screen-Shot-2020-11-10-at-13.28.03-PM.png',
                fit: BoxFit.fitWidth,
                width: 100.0,
                height: 100.0,
              ),
              Image.network(
                'https://m.media-amazon.com/images/I/61ChHwbxObL._AC_SX679_.jpg',
                fit: BoxFit.fitWidth,
                width: 100.0,
                height: 100.0,
              ),
              Image.network(
                'https://m.media-amazon.com/images/I/71jG+e7roXL._AC_SL1500_.jpg',
                fit: BoxFit.fitWidth,
                width: 100.0,
                height: 100.0,
              ),
            ],
          ),
        ),
        Container(
          padding:
              const EdgeInsets.symmetric(vertical: 15.0).copyWith(left: 15.0),
          alignment: Alignment.topLeft,
          child: Text(
            'See all deals',
            style: TextStyle(
              color: Colors.cyan[800],
            ),
          ),
        )
      ],
    );
  }
}
