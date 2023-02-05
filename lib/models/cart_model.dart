import 'dart:convert';

import 'package:amazon_clone/models/product_model.dart';

class CartItem {
  final Product product;
  final int quantity;

  CartItem({
    required this.product,
    required this.quantity,
  });

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      product: Product.fromMap(map['product']),
      quantity: map['quantity'],
    );
  }

  factory CartItem.fromJson(String source) =>
      CartItem.fromMap(json.decode(source));
}
