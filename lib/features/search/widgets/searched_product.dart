import 'package:amazon_clone/common/widgets/stars.dart';
import 'package:amazon_clone/features/product_details/widgets/product_price.dart';
import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';
import '../../../models/product_model.dart';
import '../../product_details/screens/product_details_screens.dart';

class SearchedProduct extends StatelessWidget {
  final Product product;

  const SearchedProduct({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double totalRating = 0;
    double avgRating = 0;

    for (var rating in product.ratings!) {
      totalRating += rating.rating;
    }
    if (totalRating != 0) {
      avgRating = totalRating / product.ratings!.length;
    }
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          ProductDetailsScreen.routeName,
          arguments: product,
        );
      },
      child: Container(
        height: 145.0,
        margin: const EdgeInsets.symmetric(horizontal: 10.0),
        decoration: BoxDecoration(
            border: Border.all(
          color: Colors.black12,
        )),
        child: Row(
          children: [
            SizedBox(
              width: 135.0,
              child: Image.network(
                product.images[0],
                height: 120.0,
                width: 120.0,
              ),
            ),
            Container(
              height: 100.0,
              width: 2.0,
              color: Colors.black12,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 235.0,
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    product.name,
                    maxLines: 2,
                    style: const TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ),
                Opacity(
                  opacity: product.ratings!.isEmpty ? 0 : 1,
                  child: Container(
                    width: 235.0,
                    padding: const EdgeInsets.only(left: 10.0, top: 5.0),
                    child: Row(
                      children: [
                        Stars(rating: avgRating, itemSize: 17),
                        const SizedBox(width: 5),
                        Text(
                          '$avgRating',
                          style: const TextStyle(
                            color: AppColors.textTeal,
                            fontSize: 13.5,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          '(${product.ratings!.length})',
                          style: const TextStyle(
                            color: Colors.black87,
                            fontSize: 13.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 235.0,
                  padding: const EdgeInsets.only(left: 10.0, top: 5.0),
                  child: ProductPrice(price: product.price, isSearch: true, textSize: 20, subTextSize: 13),
                ),
                Container(
                  width: 235.0,
                  padding: const EdgeInsets.only(left: 10.0),
                  child: const Text('Eligible for free shipping'),
                ),
                if (product.quantity <= 4 && product.quantity != 0)
                  Container(
                    width: 235.0,
                    padding: const EdgeInsets.only(left: 10.0, top: 5.0),
                    child:  Text(
                      'Only ${product.quantity.toInt()} left in stock - order soon',
                      maxLines: 2,
                      style: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                if (product.quantity == 0)
                  Container(
                    width: 235.0,
                    padding: const EdgeInsets.only(left: 10.0, top: 5.0),
                    child:  const Text(
                      'Out of stock',
                      maxLines: 2,
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w300,
                      ),
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
