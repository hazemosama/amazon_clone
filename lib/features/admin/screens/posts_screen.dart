import 'package:amazon_clone/features/account/widgets/single_product.dart';
import 'package:amazon_clone/features/admin/screens/add_product_screen.dart';
import 'package:amazon_clone/features/admin/services/admin_services.dart';
import 'package:amazon_clone/providers/products_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/app_colors.dart';
import '../../../models/product_model.dart';
import '../widgets/loader.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({Key? key}) : super(key: key);

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  final AdminServices adminServices = AdminServices();

  @override
  void initState() {
    fetchAllProducts();
    super.initState();
  }

  void fetchAllProducts() {
    Provider.of<ProductProvider>(context, listen: false).fetchAllProducts(context);
  }

  void navigateToAddProduct() {
    Navigator.pushNamed(context, AddProductScreen.routeName);
  }

  void deleteProduct({required Product product, required int index}) {
    adminServices.deleteProduct(
      context: context,
      product: product,
      onSuccess: () {
        // products!.removeAt(index);
        // setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Product>? products = Provider.of<ProductProvider>(context).products;
    return Scaffold(
            body: products == null
                ? const Loader()
                : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return Column(
                  children: [
                    SizedBox(
                      height: 140.0,
                      child: SingleProduct(
                        image: product.images[0],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Text(
                            product.name,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                        IconButton(
                          onPressed: () =>
                              deleteProduct(product: product, index: index),
                          icon: const Icon(Icons.delete_outline),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
            floatingActionButton: FloatingActionButton(
              tooltip: 'Add a product',
              onPressed: navigateToAddProduct,
              backgroundColor: AppColors.secondaryColor,
              child: const Icon(Icons.add),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
