import 'dart:convert';
import 'dart:io';

import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/models/product_model.dart';
import 'package:amazon_clone/providers/products_provider.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../constants/global_variables.dart';

class AdminServices {

  void sellProduct({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required double quantity,
    required String category,
    required List<File> images,
  }) async {
    final userToken =
        Provider.of<UserProvider>(context, listen: false).user.token;
    try {
      final cloudinary = CloudinaryPublic('dxesxqwii', 'y8dh05ir');
      List<String> imageUrls = [];

      for (File image in images) {
        CloudinaryResponse res = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(image.path, folder: name),
        );
        imageUrls.add(res.secureUrl);
      }
      Product product = Product(
        name: name,
        description: description,
        price: price,
        quantity: quantity,
        category: category.toLowerCase(),
        images: imageUrls,
      );

      http.Response res = await http.post(
        Uri.parse('$uri/api/admin/add-product'),
        body: product.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userToken,
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(context, "Product Added Successfully!");
          Provider.of<ProductProvider>(context, listen: false).fetchAllProducts(context);
          Navigator.pop(context);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<List<Product>> fetchAllProducts(BuildContext context) async {
    final userToken =
        Provider.of<UserProvider>(context, listen: false).user.token;
    List<Product> productsList = [];
    try {
      http.Response res = await http.get(
        Uri.parse("$uri/api/admin/get-products"),
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

  Future<void> deleteProduct({
    required BuildContext context,
    required Product product,
    required VoidCallback onSuccess,
  }) async {
    final userToken =
        Provider.of<UserProvider>(context, listen: false).user.token;
    try {
      http.Response res = await http.delete(
        Uri.parse('$uri/api/admin/delete-product/${product.id}'),
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
          Provider.of<ProductProvider>(context, listen: false).fetchAllProducts(context);
          onSuccess();
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
