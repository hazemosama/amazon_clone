import 'dart:convert';

import 'package:amazon_clone/common/screens/home_layout.dart';
import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/user_model.dart';

class AuthService {
  void signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
    required String phoneNumber,
  }) async {
    try {
      User user = User(
        id: '',
        name: name,
        password: password,
        email: email,
        address: '',
        type: '',
        token: '',
        cart: [],
        phoneNumber: phoneNumber,
      );

      http.Response res = await http.post(
        Uri.parse('$uri/api/auth/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(
            context,
            'Account created! Login with the same credentials!',
          );
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
   UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
   var navigator = Navigator.of(context);
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/auth/signin'),
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          userProvider.setUser(res.body);
          await prefs.setString(
              "x-auth-token", jsonDecode(res.body)['data']['token']);
          navigator.pushNamedAndRemoveUntil(
              HomeLayout.routeName, (route) => false);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<void> getUserData(
    BuildContext context,
  ) async {
    UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("x-auth-token");
      if (token == null) {
        prefs.setString("x-auth-token", "");
      }

      var tokenRes = await http.post(
        Uri.parse('$uri/api/auth/token-verification'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': '$token',
        },
      );

      var response = jsonDecode(tokenRes.body);
      if (response == true) {
        http.Response userRes = await http.get(
          Uri.parse('$uri/api/user/get-user-data'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': '$token',
          },
        );

        await userProvider.setUser(userRes.body);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      // I did this because when there's an error from API snackBar
      // will not be displayed and will get an error because
      // there's no scaffold when we use this function in main.dart before building materialApp.

      // showSnackBar(context, e.toString());
    }
  }
}
