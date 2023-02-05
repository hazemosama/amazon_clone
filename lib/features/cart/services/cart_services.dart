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

class CartServices {
  Future<void> increaseQuantity({
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
          UserProvider userProvider =
              Provider.of<UserProvider>(context, listen: false);

          List<CartItem> finalCart =
              List.from(jsonDecode(res.body)["data"]["cart"])
                  .map((e) => CartItem.fromMap(e))
                  .toList();
          User user = userProvider.user.copyWith(
            cart: finalCart,
          );
          userProvider.setUserFromModel(user);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<void> decreaseQuantity({
    required BuildContext context,
    required Product product,
  }) async {
    final userToken =
        Provider.of<UserProvider>(context, listen: false).user.token;
    try {
      http.Response res = await http.delete(
        Uri.parse('$uri/api/cart/decrease/${product.id}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userToken,
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          UserProvider userProvider =
              Provider.of<UserProvider>(context, listen: false);

          List<CartItem> finalCart =
              List.from(jsonDecode(res.body)["data"]["cart"])
                  .map((e) => CartItem.fromMap(e))
                  .toList();
          User user = userProvider.user.copyWith(
            cart: finalCart,
          );
          userProvider.setUserFromModel(user);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<void> removeFromCart({
    required BuildContext context,
    required Product product,
  }) async {
    final userToken =
        Provider.of<UserProvider>(context, listen: false).user.token;
    try {
      http.Response res = await http.delete(
        Uri.parse('$uri/api/cart/remove/${product.id}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userToken,
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          UserProvider userProvider =
              Provider.of<UserProvider>(context, listen: false);

          List<CartItem> finalCart =
              List.from(jsonDecode(res.body)["data"]["cart"])
                  .map((e) => CartItem.fromMap(e))
                  .toList();
          User user = userProvider.user.copyWith(
            cart: finalCart,
          );
          userProvider.setUserFromModel(user);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<void> placeOrder({
    required BuildContext context,
    required String address,
    required double totalSum,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/cart/order'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'address': address,
          'totalPrice': totalSum,
        }),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(context, jsonDecode(res.body)['message']);
          User user = userProvider.user.copyWith(
            cart: [],
          );
          userProvider.setUserFromModel(user);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
