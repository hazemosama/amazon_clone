import 'package:amazon_clone/features/admin/services/admin_services.dart';
import 'package:amazon_clone/features/home/services/home_services.dart';
import 'package:flutter/material.dart';

import '../models/product_model.dart';

class ProductProvider extends ChangeNotifier {

  List<Product>? _products;

  List<Product>? get products => _products;

  AdminServices adminServices = AdminServices();

  void fetchAllProducts(BuildContext context) async {
    _products = await adminServices.fetchAllProducts(context);
    notifyListeners();
  }
  List<Product>? _todayDeals;
  List<Product>? get todayDeals => _todayDeals;

  HomeServices homeServices = HomeServices();

  void fetchTodayDeals(BuildContext context) async {
    _todayDeals = await homeServices.fetchTodayDeals(context: context);
    notifyListeners();
  }

  void addProduct(Product product) {
    _products!.add(product);
    notifyListeners();
  }


}