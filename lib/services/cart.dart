import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xshop_mobile/models/cart.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

// =================================================================================
SharedPreferences sharedPreferences;
Map<String, String> headers = {};

class Session {
  Map<String, String> headers = {};

  Future<Map> post() async {
    sharedPreferences = await SharedPreferences.getInstance();
    final response = await http.post(
      Uri.parse('https://dev-egshops.herokuapp.com/api/cart/'),
      headers: <String, String>{
        "accept": " */*",
        "Content-Type": "application/json",
        "Authorization": "Token ${sharedPreferences.getString("token")}"
      },
      body: jsonEncode(
          <String, dynamic>{"product_id": 2, "quantity": 1, "actions": "add"}),
    );
    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
      updateCookie(response);
      print("======data=====\n");
      print(json.decode(response.body));
    }
  }
}

// =================================================================================
Future<List<Cart>> getCart() async {
  sharedPreferences = await SharedPreferences.getInstance();
  final response = await http.get(
    Uri.parse('https://dev-egshops.herokuapp.com/api/cart/'),
    headers: <String, String>{
      "accept": " */*",
      "Content-Type": "application/json",
      "Authorization": "Token ${sharedPreferences.getString("token")}",
      HttpHeaders.cookieHeader: sharedPreferences.getString("sessionid")
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
  sharedPreferences = await SharedPreferences.getInstance();
  final response = await http.post(
    Uri.parse('https://dev-egshops.herokuapp.com/api/cart/'),
    headers: <String, String>{
      "accept": " */*",
      "Content-Type": "application/json",
      "Authorization": "Token ${sharedPreferences.getString("token")}",
      HttpHeaders.cookieHeader: sharedPreferences.getString("sessionid")
    },
    body: jsonEncode(<String, dynamic>{
      "product_id": id,
      "quantity": quantity,
      "actions": action
    }),
  );
  if (response.statusCode == 200) {
    print(jsonDecode(response.body));
    updateCookie(response);
    final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();

    return parsed.map<Cart>((json) => Cart.fromJson(json)).toList();
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    return null;
  }
}

Future<List<Cart>> removeCart(int id, int quantity, String action) async {
  sharedPreferences = await SharedPreferences.getInstance();
  final response = await http.post(
    Uri.parse('https://dev-egshops.herokuapp.com/api/cart/'),
    headers: <String, String>{
      "accept": " */*",
      "Content-Type": "application/json",
      "Authorization": "Token ${sharedPreferences.getString("token")}",
      HttpHeaders.cookieHeader: sharedPreferences.getString("sessionid")
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

Future<List<Cart>> updateCart(int id, int quantity, String action) async {
  sharedPreferences = await SharedPreferences.getInstance();
  final response = await http.post(
    Uri.parse('https://dev-egshops.herokuapp.com/api/cart/'),
    headers: <String, String>{
      "accept": " */*",
      "Content-Type": "application/json",
      "Authorization": "Token ${sharedPreferences.getString("token")}",
      HttpHeaders.cookieHeader: sharedPreferences.getString("sessionid")
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

void updateCookie(http.Response response) async {
  String rawCookie = response.headers['set-cookie'];
  if (rawCookie != null) {
    int index = rawCookie.indexOf(';');
    headers['cookie'] =
        (index == -1) ? rawCookie : rawCookie.substring(0, index);
  }
  print("======kookie=====\n");
  print(rawCookie.split(';')[0]);
  sharedPreferences.setString('sessionid', rawCookie.split(';')[0]);
}
