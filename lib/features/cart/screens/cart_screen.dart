import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/features/cart/services/cart_services.dart';
import 'package:amazon_clone/features/cart/widgets/cart_item_container.dart';
import 'package:amazon_clone/features/product_details/widgets/product_price.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/widgets/address_box.dart';
import '../../../common/widgets/custom_appbar.dart';
import '../../../constants/app_colors.dart';
import '../../../providers/user_provider.dart';

class CartScreen extends StatefulWidget {
  static const String routeName = '/cart';

  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  CartServices cartServices = CartServices();

  @override
  Widget build(BuildContext context) {
    final userCartLength = context.watch<UserProvider>().user.cart!.length;
    final user = context.watch<UserProvider>().user;
    dynamic sum = 0;
    user.cart?.map((e) => sum += e.quantity * e.product.price).toList();

    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(68),
        child: CustomAppBar(backButton: false),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AddressBox(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Text(
                        'Subtotal',
                        style: TextStyle(fontSize: 23),
                      ),
                      const SizedBox(width: 6),
                      ProductPrice(
                        price: sum.toDouble(),
                        bold: true,
                        textSize: 25,
                        subTextSize: 14,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 11.5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          CupertinoIcons.check_mark_circled_solid,
                          color: AppColors.green2,
                        ),
                        const SizedBox(width: 3),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Your order qualifies for FREE Shipping',
                              style: TextStyle(
                                fontSize: 17,
                                color: AppColors.green2,
                              ),
                            ),
                            Row(
                              children: [
                                const Text(
                                  'Choose this option at checkout.',
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: Color(0xA5000000),
                                  ),
                                ),
                                TextButton(
                                  style: TextButton.styleFrom(
                                    minimumSize: const Size(50, 25),
                                    padding: EdgeInsets.zero,
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    alignment: Alignment.centerLeft,
                                  ),
                                  onPressed: () {},
                                  child: const Text(
                                    ' See details',
                                    style: TextStyle(
                                      color: AppColors.textTeal,
                                      fontSize: 17,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  CustomButton(
                    text: 'Proceed to Buy ($userCartLength items)',
                    color: const Color(0xffffd814),
                    radius: 10,
                    textSize: 17,
                    height: 54,
                    enabled: userCartLength > 0,
                    onPressed: () {
                      cartServices.placeOrder(
                        context: context,
                        address: user.address,
                        totalSum: sum,
                      );
                    },
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 12),
                    height: 1,
                    color: Colors.black12,
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) =>
                        CartItemContainer(index: index),
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 8),
                    itemCount: userCartLength,
                    physics: const NeverScrollableScrollPhysics(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
