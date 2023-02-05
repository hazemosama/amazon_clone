import 'package:amazon_clone/features/cart/services/cart_services.dart';
import 'package:amazon_clone/models/cart_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/app_colors.dart';
import '../../../models/product_model.dart';
import '../../../providers/user_provider.dart';
import '../../product_details/screens/product_details_screens.dart';
import '../../product_details/widgets/product_price.dart';
import 'cart_button.dart';
import 'cart_button2.dart';

class CartItemContainer extends StatefulWidget {
  final int index;

  const CartItemContainer({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  State<CartItemContainer> createState() => _CartItemContainerState();
}

class _CartItemContainerState extends State<CartItemContainer> {
  final CartServices cartServices =
  CartServices();

  void increaseQuantity(Product product) {
    cartServices.increaseQuantity(context: context, product: product);
  }
  void decreaseQuantity(Product product) {
    cartServices.decreaseQuantity(context: context, product: product);
  }

  void removeFromCart(Product product) {
    cartServices.removeFromCart(context: context, product: product);
  }

  @override
  Widget build(BuildContext context) {
    final CartItem cartItem =
        context.watch<UserProvider>().user.cart![widget.index];
    final Product product = cartItem.product;
    final bool inStock = product.quantity != 0;

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          ProductDetailsScreen.routeName,
          arguments: product,
        );
      },
      child: Container(
        height: 240,
        padding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 7,
        ),
        decoration: BoxDecoration(
          color: const Color(0x3AE3E1E1),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.network(
                  product.images[0],
                  height: 158,
                  width: 115,
                  fit: BoxFit.contain,
                ),
                const Spacer(),
                Card(
                  elevation: 1,
                  margin: const EdgeInsets.only(bottom: 3),
                  borderOnForeground: false,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      CartButton2(
                        icon: cartItem.quantity > 1  ? CupertinoIcons.minus : CupertinoIcons.trash,
                        position: CartButton2Position.left,
                        onPressed: () => decreaseQuantity(product),
                      ),
                      Container(
                        width: 58,
                        height: 37.5,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black12,
                            width: 1.5,
                          ),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(0),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          '${cartItem.quantity}',
                          style: const TextStyle(
                            color: AppColors.teal,
                            fontSize: 19.5,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      CartButton2(
                        icon: CupertinoIcons.add,
                        position: CartButton2Position.right,
                        onPressed: () => increaseQuantity(product),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 194,
                  child: Text(
                    product.name,
                    maxLines: 2,
                    style: const TextStyle(
                      fontSize: 17,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                ProductPrice(
                  price: product.price,
                  textSize: 25,
                  subTextSize: 13,
                  bold: true,
                ),
                const SizedBox(height: 8),
                const Text(
                  'Eligible for FREE delivery',
                  style: TextStyle(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 11),
                Text(
                  inStock
                      ? product.quantity < 5
                          ? 'Only ${product.quantity.toInt()} left. Order now '
                          : 'In Stock'
                      : 'Out of stock',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w500,
                    color: inStock ? AppColors.green : Colors.red,
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 3),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CartButton(text: 'Delete',onPressed: () => removeFromCart(product), ),
                      const SizedBox(width: 9),
                      CartButton(text: 'Save for later', onPressed: () {},),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
