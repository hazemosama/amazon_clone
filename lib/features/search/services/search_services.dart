import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../../constants/error_handling.dart';
import '../../../constants/global_variables.dart';
import '../../../constants/utils.dart';
import '../../../models/product_model.dart';
import '../../../providers/user_provider.dart';

class SearchServices {
  Future<List<Product>> fetchSearchedProduct({
    required BuildContext context,
    required String searchQuery,
  }) async {
    final userToken =
        Provider.of<UserProvider>(context, listen: false).user.token;
    List<Product> productsList = [];
    try {
      http.Response res = await http.get(
        Uri.parse("$uri/api/products/search/$searchQuery"),
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
