import 'dart:convert';

import 'package:amazon_clone/models/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../constants/error_handling.dart';
import '../../../constants/global_variables.dart';
import '../../../constants/utils.dart';
import '../../../models/product_model.dart';
import '../../../models/user_model.dart';
import '../../../providers/user_provider.dart';

class ProductDetailsServices {
  Future<void> rateProduct({
    required BuildContext context,
    required Product product,
    required double rating,
  }) async {
    final userToken =
        Provider.of<UserProvider>(context, listen: false).user.token;
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/products/rate-product'),
        body: jsonEncode({
          "id": product.id!,
          "rating": rating,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userToken,
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(context, json.decode(res.body)["message"]);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<void> addToCart({
    required BuildContext context,
    required Product product,
  }) async {
    final userToken =
        Provider.of<UserProvider>(context, listen: false).user.token;
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/cart/add'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userToken,
        },
        body: jsonEncode({
          "product_id": product.id!,
        }),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);

          List<CartItem> finalCart = List.from(jsonDecode(res.body)["data"]["cart"]).map((e) => CartItem.fromMap(e)).toList();
          User user = userProvider.user.copyWith(
                cart: finalCart,
              );
          userProvider.setUserFromModel(user);
          showSnackBar(context, json.decode(res.body)["message"]);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
