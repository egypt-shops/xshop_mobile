import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

Future<List<Orders>> fetchInvoices(http.Client client) async {
  final response = await client
      .get('https://dev-egshops.herokuapp.com/api/invoices/?format=json');

  // Use the compute function to run parseInvoices in a separate isolate.
  return compute(parseInvoices, response.body);
}

// A function that converts a response body into a List<Product>.
List<Orders> parseInvoices(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Orders>((json) => Orders.fromJson(json)).toList();
}

class Orders {
  final int id;
  final int user;
  final int shop;
  final bool paid;

  Orders({this.id, this.user, this.shop, this.paid});

  factory Orders.fromJson(Map<String, dynamic> json) {
    return Orders(
      user: json['user'] as int,
      id: json['id'] as int,
      shop: json['shop'] as int,
      paid: json['paid'] as bool,
    );
  }
}
