import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:xshop_mobile/models/cart.dart';
import 'package:xshop_mobile/screens/home/home.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

// =================================================================================
Future<List<Cart>> getCart() async {
  final response = await http.get(
    Uri.parse('https://dev-egshops.herokuapp.com/api/cart/'),
    headers: <String, String>{
      "accept": " */*",
      "Content-Type": "application/json",
      "Authorization": "Token ${sharedPreferences.getString("token")}"
    },
  );
  if (response.statusCode == 200) {
    return compute(parseCart, response.body);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load cart');
  }
}

Future<List<Cart>> postCart(int id, int quantity, String action) async {
  final response = await http.post(
    Uri.parse('https://dev-egshops.herokuapp.com/api/cart/'),
    headers: <String, String>{
      "accept": " */*",
      "Content-Type": "application/json",
      "Authorization": "Token ${sharedPreferences.getString("token")}"
    },
    body: jsonEncode(<String, dynamic>{
      "product_id": id,
      "quantity": quantity,
      "actions": action
    }),
  );
  if (response.statusCode == 200) {
    print(jsonDecode(response.body));
    final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();

    return parsed.map<Cart>((json) => Cart.fromJson(json)).toList();
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    return null;
  }
}

List<Cart> parseCart(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Cart>((json) => Cart.fromJson(json)).toList();
}
