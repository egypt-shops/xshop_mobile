import 'dart:convert';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:xshop_mobile/models/order.dart';

Future<Order> createOrder(
    String id, String user, String shop, String paid) async {
  final response = await http.post(
    Uri.https('https://dev-egshops.herokuapp.com/api/orders/', 'albums'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'id': id,
      'user': user,
      'shop': shop,
      'paid': paid,
    }),
  );

  if (response.statusCode == 201) {
    return Order.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to create album.');
  }
}
