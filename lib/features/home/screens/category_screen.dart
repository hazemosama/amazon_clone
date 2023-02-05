import 'package:amazon_clone/common/widgets/custom_appbar.dart';
import 'package:amazon_clone/features/home/services/home_services.dart';
import 'package:amazon_clone/features/home/widgets/category_product.dart';
import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';
import '../../../models/product_model.dart';
import '../../admin/widgets/loader.dart';

class CategoryScreen extends StatefulWidget {
  static const String routeName = '/category';
  final String category;

  const CategoryScreen({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<Product>? productList;
  final HomeServices homeServices = HomeServices();

  @override
  void initState() {
    fetchCategoryProducts();
    super.initState();
  }

  void fetchCategoryProducts() async {
    productList = await homeServices.fetchCategoryProducts(
      context: context,
      category: widget.category,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(64),
        child: CustomAppBar(
          backButton: true,
          searchHint: 'Search in ${widget.category}',
        ),
      ),
      body: productList == null
          ? const Loader()
          : Padding(
              padding: const EdgeInsets.symmetric(vertical: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      widget.category,
                      style: const TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: 50,
                    width: double.infinity,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xffd5d9d9),
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Text(
                          'Over ${productList!.length} results in ${widget.category}',
                          style: const TextStyle(
                            fontSize: 16,
                            height: 1,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            padding: EdgeInsets.zero,
                            minimumSize: Size.zero,
                          ),
                          child: const Text(
                            'Filter',
                            style: TextStyle(
                                color: AppColors.textTeal,
                                fontWeight: FontWeight.w500,
                                height: 1),
                          ),
                        ),
                        const Icon(
                          Icons.double_arrow_sharp,
                          size: 10,
                          color: AppColors.textTeal,
                        ),
                        const SizedBox(width: 4),
                        const Icon(
                          Icons.keyboard_arrow_down,
                          size: 15,
                          color: Colors.black54,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  Expanded(
                    child: ListView.separated(
                      itemBuilder: (context, index) =>
                          CategoryProduct(product: productList![index]),
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 15),
                      itemCount: productList!.length,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
