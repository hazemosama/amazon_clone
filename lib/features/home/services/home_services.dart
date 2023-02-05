import 'dart:convert';

import 'package:amazon_clone/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../constants/error_handling.dart';
import '../../../constants/global_variables.dart';
import '../../../constants/utils.dart';
import '../../../providers/user_provider.dart';

class HomeServices {
  Future<List<Product>> fetchCategoryProducts({
    required BuildContext context,
    required String category,
  }) async {
    final userToken =
        Provider.of<UserProvider>(context, listen: false).user.token;
    List<Product> productsList = [];
    try {
      http.Response res = await http.get(
        Uri.parse("$uri/api/products?category=${category.toLowerCase()}"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userToken,
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          List<dynamic> fetchedList = json.decode(res.body)["data"];
          for (var product in fetchedList) {
            productsList.add(Product.fromMap(product));
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return productsList;
  }

  Future<List<Product>> fetchTodayDeals({
    required BuildContext context,
  }) async {
    final userToken =
        Provider.of<UserProvider>(context, listen: false).user.token;
    List<Product> productsList = [];
    try {
      http.Response res = await http.get(
        Uri.parse("$uri/api/products/today-deals"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userToken,
        },
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          List<dynamic> fetchedList = json.decode(res.body)["data"];
          for (var product in fetchedList) {
            productsList.add(Product.fromMap(product));
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return productsList;
  }
}
