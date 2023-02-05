import 'dart:convert';

import 'package:amazon_clone/models/cart_model.dart';

class User {
  final String id;
  final String name;
  final String email;
  final String password;
  final String address;
  final String phoneNumber;
  final String type;
  final String token;
  final List<CartItem>? cart;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.address,
    required this.type,
    required this.token,
    required this.phoneNumber,
    this.cart,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'address': address,
      'type': type,
      'token': token,
      'cart': cart,
      'phone_number': phoneNumber,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      phoneNumber: map['phone_number'],
      address: map['address'] ?? '',
      type: map['type'] ?? '',
      token: map['token'] ?? '',
      cart: map['cart'] != null ? List<CartItem>.from(
        map['cart'].map(
          (x) => CartItem.fromMap(x),
        ),
      ) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source)['data']);

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? password,
    String? address,
    String? type,
    String? token,
    String? phoneNumber,
    List<CartItem>? cart,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      address: address ?? this.address,
      type: type ?? this.type,
      token: token ?? this.token,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      cart: cart ?? this.cart,
    );
  }
}
