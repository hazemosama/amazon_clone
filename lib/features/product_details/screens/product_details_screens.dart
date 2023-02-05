import 'package:amazon_clone/common/widgets/address_box.dart';
import 'package:amazon_clone/features/product_details/services/product_details_services.dart';
import 'package:amazon_clone/features/product_details/widgets/product_price.dart';
import 'package:amazon_clone/models/product_model.dart';
import 'package:amazon_clone/models/user_model.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../common/widgets/custom_appbar.dart';
import '../../../common/widgets/custom_button.dart';
import '../../../common/widgets/stars.dart';
import '../../../constants/app_colors.dart';
import '../../search/screens/search_screen.dart';
import '../widgets/screen_divider.dart';

class ProductDetailsScreen extends StatefulWidget {
  static const String routeName = 'product-details';
  final Product product;

  const ProductDetailsScreen({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  double avgRating = 0;
  double myRating = 0;

  void addToCart() {
    productDetailsServices.addToCart(context: context, product: widget.product);
  }

  @override
  void initState() {
    super.initState();
    double totalRating = 0;
    for (var rating in widget.product.ratings!) {
      totalRating += rating.rating;
      if (rating.userId ==
          Provider.of<UserProvider>(context, listen: false).user.id) {
        myRating = rating.rating;
      }
    }

    if (totalRating != 0) {
      avgRating = totalRating / widget.product.ratings!.length;
    }
  }

  void navigateToSearchScreen(String searchQuery) {
    Navigator.pushNamed(
      context,
      SearchScreen.routeName,
      arguments: searchQuery,
    );
  }

  PageController pageController = PageController();

  final ProductDetailsServices productDetailsServices =
      ProductDetailsServices();

  EdgeInsets screenPadding = const EdgeInsets.all(14);
  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(66),
        child: CustomAppBar(
          backButton: true,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AddressBox(),
            Padding(
              padding: screenPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Category: ${widget.product.category}',
                        style: const TextStyle(
                          color: AppColors.textTeal,
                        ),
                      ),
                      Visibility(
                        visible: widget.product.ratings!.isNotEmpty,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Stars(
                              rating: avgRating,
                              itemSize: 25.0,
                            ),
                            const SizedBox(
                              height: 2.0,
                            ),
                            Text(
                              '${widget.product.ratings!.length}',
                              style: const TextStyle(
                                color: AppColors.textTeal,
                                fontSize: 15.0,
                              ),
                              textAlign: TextAlign.end,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    widget.product.name,
                    style: const TextStyle(
                      fontSize: 19.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 460,
                    child: PageView.builder(
                      controller: pageController,
                      itemBuilder: (context, index) => Image.network(
                        widget.product.images[index],
                        fit: BoxFit.contain,
                      ),
                      itemCount: widget.product.images.length,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Center(
                    child: SmoothPageIndicator(
                      controller: pageController,
                      count: widget.product.images.length,
                      effect: const ExpandingDotsEffect(
                        activeDotColor: AppColors.textTeal,
                        dotColor: Colors.black12,
                        dotHeight: 10.0,
                        dotWidth: 10.0,
                        spacing: 5.0,
                      ),
                    ),
                  ),
                  if (widget.product.quantity > 0)
                    ProductPrice(
                      price: widget.product.price,
                      textSize: 38,
                      subTextSize: 16,
                    ),
                  const SizedBox(height: 9),
                  const Text(
                    'FREE Returns',
                    style: TextStyle(
                      color: AppColors.textTeal,
                      fontSize: 15.5,
                    ),
                  ),
                  const Text(
                    'All prices include VAT.',
                    style: TextStyle(
                      fontSize: 15.5,
                    ),
                  ),
                  const SizedBox(height: 9),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        size: 18.0,
                      ),
                      const SizedBox(width: 3),
                      Text(
                        'Deliver to ${user.name} - ${user.address}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 15.5,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textTeal,
                          height: 1.7
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Text(
                    widget.product.quantity > 0
                        ? widget.product.quantity <= 3
                            ? 'Only ${widget.product.quantity.toInt()} left in stock - order soon.'
                            : 'In stock'
                        : 'Out of stock',
                    style: TextStyle(
                      color: widget.product.quantity > 0
                          ? AppColors.green
                          : Colors.red,
                      fontSize: 19,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 16),
                  CustomButton(
                    text: 'Add to Cart',
                    color: const Color(0xfffed813),
                    onPressed: addToCart,
                    enabled: widget.product.quantity > 0,
                  ),
                  const SizedBox(height: 10),
                  CustomButton(
                    text: 'Buy Now',
                    onPressed: () async {},
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: const [
                      SizedBox(
                        width: 200,
                        child: Text(
                          'Delivered by',
                          style: TextStyle(
                            fontSize: 13.5,
                            color: Color(0xff646665),
                          ),
                        ),
                      ),
                      Text(
                        'Amazon.eg',
                        style: TextStyle(
                          fontSize: 13.5,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: const [
                      SizedBox(
                        width: 200,
                        child: Text(
                          'Sold by',
                          style: TextStyle(
                            fontSize: 13.5,
                            color: Color(0xff646665),
                          ),
                        ),
                      ),
                      Text(
                        'Amazon.eg',
                        style: TextStyle(
                          fontSize: 13.5,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(0, 0),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: const Text(
                      'Add to List',
                      style: TextStyle(
                        color: AppColors.textTeal,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const ScreenDivider(),
            Padding(
              padding: screenPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Details',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.product.description,
                    style: const TextStyle(
                      fontSize: 15.5,
                      height: 2.0,
                    ),
                  ),
                ],
              ),
            ),
            const ScreenDivider(),
            Padding(
              padding: screenPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Rate The Product',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  RatingBar.builder(
                    initialRating: myRating,
                    minRating: 1.0,
                    maxRating: 5.0,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    unratedColor: Colors.black12,
                    glow: false,
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: AppColors.secondaryColor,
                    ),
                    onRatingUpdate: (double rating) {
                      productDetailsServices.rateProduct(
                        context: context,
                        product: widget.product,
                        rating: rating,
                      );
                    },
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
