import 'dart:convert';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:xshop_mobile/models/order.dart';

Future<Order> fetchOrderByID(http.Client client, String id) async {
  final response = await http
      .get('https://dev-egshops.herokuapp.com/api/orders/$id/?format=json');
  if (response.statusCode == 200) {
    return compute(parsedOrder, response.body);
  } else {
    return Order(exist: 'notFound');
  }
}

Order parsedOrder(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<String, dynamic>();
  return Order.fromJson(parsed);
}
