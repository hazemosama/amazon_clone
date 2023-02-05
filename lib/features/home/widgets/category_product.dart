import 'package:amazon_clone/common/widgets/stars.dart';
import 'package:amazon_clone/features/product_details/widgets/product_price.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../models/product_model.dart';
import '../../product_details/screens/product_details_screens.dart';

class CategoryProduct extends StatelessWidget {
  final Product product;

  const CategoryProduct({Key? key, required this.product}) : super(key: key);

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
    final bool inStock = product.quantity != 0;
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    final formatter = DateFormat('MMM dd');
    String formattedDate = formatter.format(tomorrow);

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          ProductDetailsScreen.routeName,
          arguments: product,
        );
      },
      child: Container(
        constraints: const BoxConstraints(minHeight: 100, maxHeight: 208),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xfff5f5f5),
          ),
        ),
        child: Row(
          children: [
            Container(
              constraints: const BoxConstraints(minHeight: 100, maxHeight: 208),
              width: 155,
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: const BoxDecoration(
                color: Color(0xfff8f8f8),
              ),
              child: Center(
                child: Image.network(
                  product.images[0],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 194,
                    child: Text(
                      product.name,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 14.5, height: 1.23),
                    ),
                  ),
                  if (product.ratings!.isEmpty) const SizedBox(height: 6),
                  Visibility(
                    visible: product.ratings!.isNotEmpty,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Row(
                        children: [
                          Stars(rating: avgRating, itemSize: 17),
                          const SizedBox(width: 5),
                          Text(
                            '${product.ratings!.length}',
                            style: const TextStyle(
                              color: Colors.black54,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    visible: inStock,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: ProductPrice(
                        price: product.price,
                        textSize: 23,
                        subTextSize: 13,
                      ),
                    ),
                  ),
                  if (inStock)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        RichText(
                          text: TextSpan(
                            text: 'Get it as soon as ',
                            style: const TextStyle(
                              fontSize: 11.75,
                              color: Colors.black45,
                            ),
                            children: [
                              TextSpan(
                                text: 'tomorrow, $formattedDate',
                                style: const TextStyle(
                                  fontSize: 11.75,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'Fulfilled by Amazon - FREE Shipping',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 11.75,
                            color: Colors.black45,
                          ),
                        ),
                      ],
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
