import 'package:amazon_clone/features/account/widgets/single_product.dart';
import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {

  // temp list
  List dummyList = [
    'https://m.media-amazon.com/images/I/81spj+QN-VL._AC_SL1500_.jpg',
    'https://m.media-amazon.com/images/I/91UQAYF2zBL._AC_SL1500_.jpg',
    'https://m.media-amazon.com/images/I/71rRkLhu05L._AC_SL1500_.jpg',
    'https://m.media-amazon.com/images/I/418I1gX3FFL._AC_SL1080_.jpg',
    'https://m.media-amazon.com/images/I/918TF3nrrvL._AC_SL1500_.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 15),
              child: const Text(
                'Your Orders',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(right: 15),
              child: const Text(
                'See all',
                style: TextStyle(
                  color: AppColors.teal,
                ),
              ),
            ),
          ],
        ),
        //Orders
        Container(
          height: 170.0,
          padding: const EdgeInsets.only(left: 10, right: 0, top: 20),
          child: ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) => SingleProduct(image: dummyList[index]),
            scrollDirection: Axis.horizontal,
          ),
        ),
      ],
    );
  }
}
