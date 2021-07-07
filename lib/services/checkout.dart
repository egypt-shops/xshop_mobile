import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences sharedPreferences;
Future<int> register(http.Client client, String address) async {
  sharedPreferences = await SharedPreferences.getInstance();
  final response = await client.post(
      Uri.parse("https://dev-egshops.herokuapp.com/api/orders/checkout/"),
      headers: <String, String>{
        "accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Token ${sharedPreferences.getString("token")}",
        HttpHeaders.cookieHeader: sharedPreferences.getString("sessionid")
      },
      body: jsonEncode(<String, dynamic>{
        "address": address,
      }));
  if (response.statusCode == 200) {
    print('====================== checked out ============================');
    return response.statusCode;
  } else {
    throw Exception('failed to checkout to $address');
  }
}
