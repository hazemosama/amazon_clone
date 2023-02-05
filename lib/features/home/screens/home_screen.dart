import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/widgets/address_box.dart';
import '../../../common/widgets/carousel_images.dart';
import '../../../common/widgets/custom_appbar.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/global_variables.dart';
import '../../../models/product_model.dart';
import '../../../providers/products_provider.dart';
import '../../product_details/widgets/screen_divider.dart';
import '../../search/screens/search_screen.dart';
import '../widgets/offer_item.dart';
import '../widgets/today_deal.dart';
import '../widgets/top_categories.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    fetchTodayDeals();
  }

  void fetchTodayDeals() {
    Provider.of<ProductProvider>(context, listen: false)
        .fetchTodayDeals(context);
  }

  void navigateToSearchScreen(String searchQuery) {
    Navigator.pushNamed(
      context,
      SearchScreen.routeName,
      arguments: searchQuery,
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Product>? todayDeals =
        Provider.of<ProductProvider>(context).todayDeals;

    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(64),
        child: CustomAppBar(backButton: false),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AddressBox(),
            const ScreenDivider(),
            const SizedBox(height: 10),
            const TopCategories(),
            const ScreenDivider(),
            const CarouselImages(
              height: 254,
              images: GlobalVariables.carouselImages,
              fit: BoxFit.cover,
            ),
            Transform.translate(
              offset: const Offset(0, -10),
              child: SizedBox(
                height: 200,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => OfferItem(
                      title: GlobalVariables.dummyOffers[index]['title']!,
                      imageUrl: GlobalVariables.dummyOffers[index]['image']!,
                    ),
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 8),
                    itemCount: 5,
                  ),
                ),
              ),
            ),
            Image.network('https://www.linkpicture.com/q/ok_1.png'),
            const ScreenDivider(),
            Container(
              height: 360,
              width: double.infinity,
              padding: const EdgeInsets.all(15),
              color: const Color(0xffeaeded),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Today's Deals",
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  todayDeals != null
                      ? SizedBox(
                          height: 280,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => TodayDeal(
                              product: todayDeals[index],
                            ),
                            separatorBuilder: (context, index) =>
                                const SizedBox(width: 10),
                            itemCount: todayDeals.length,
                          ),
                        )
                      : const LinearProgressIndicator(color: AppColors.teal),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
