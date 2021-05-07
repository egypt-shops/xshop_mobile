import 'dart:convert';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:xshop_mobile/models/order.dart';

class PostOrder {
  Future<Order> createOrder(String user, String shop, bool paid) async {
    final response = await http.post(
      (Uri.parse('https://dev-egshops.herokuapp.com/api/orders/')),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'user': user,
        'shop': shop,
        'paid': paid,
      }),
    );
    print(response.body + "\n " + response.statusCode.toString());
    if (response.statusCode == 200) {
      print('order over there amigo');
      return Order.fromJson(jsonDecode(response.body));
    } else {
      print('see nothing');
      throw Exception('Failed to create Order.');
    }
  }
}
