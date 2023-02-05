import 'package:amazon_clone/common/widgets/address_box.dart';
import 'package:amazon_clone/features/search/services/search_services.dart';
import 'package:amazon_clone/features/search/widgets/searched_product.dart';
import 'package:flutter/material.dart';

import '../../../common/widgets/custom_appbar.dart';
import '../../../constants/app_colors.dart';
import '../../../models/product_model.dart';
import '../../admin/widgets/loader.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = '/search-screen';
  final String searchQuery;

  const SearchScreen({
    Key? key,
    required this.searchQuery,
  }) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Product>? products;
  final SearchServices searchServices = SearchServices();

  @override
  void initState() {
    super.initState();
    fetchSearchedProducts();
  }

  fetchSearchedProducts() async {
    products = await searchServices.fetchSearchedProduct(
      context: context,
      searchQuery: widget.searchQuery,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(72),
        child: CustomAppBar(backButton: true),
      ),
      body: products == null
          ? const Loader()
          : Column(
              children: [
                const AddressBox(),
                const SizedBox(
                  height: 10.0,
                ),
                Expanded(
                  child: ListView.separated(
                    itemCount: products!.length,
                    itemBuilder: (context, index) => SearchedProduct(
                      product: products![index],
                    ),
                    separatorBuilder: (context, index) => const SizedBox(height: 10.0,),
                  ),
                ),
              ],
            ),
    );
  }
}
