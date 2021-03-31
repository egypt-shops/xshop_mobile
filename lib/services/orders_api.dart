import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:xshop_mobile/models/order.dart';

Future<List<Order>> fetchOrders(http.Client client) async {
  final response = await client
      .get('https://dev-egshops.herokuapp.com/api/orders/?format=json');

  // Use the compute function to run parseOrders in a separate isolate.
  return compute(parseOrders, response.body);
}

// A function that converts a response body into a List<Product>.
List<Order> parseOrders(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Order>((json) => Order.fromJson(json)).toList();
}
