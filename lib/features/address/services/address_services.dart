import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../../constants/error_handling.dart';
import '../../../constants/global_variables.dart';
import '../../../constants/utils.dart';
import '../../../models/user_model.dart';
import '../../../providers/user_provider.dart';

class AddressServices {
  Future<void> saveAddress({
    required BuildContext context,
    required String address,
  }) async {
    final userToken =
        Provider.of<UserProvider>(context, listen: false).user.token;
    print(address);
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/user/save-address'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userToken,
        },
        body: jsonEncode({
          "address": address,
        }),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          var userProvider = Provider.of<UserProvider>(context, listen: false);
          User user =
              Provider.of<UserProvider>(context, listen: false).user.copyWith(
                    address: json.decode(res.body)['data']['address'],
                  );
          userProvider.setUserFromModel(user);
        },
      );
    } catch (e) {
      print(e);
      showSnackBar(context, e.toString());
    }
  }
}
