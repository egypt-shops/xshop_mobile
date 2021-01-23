import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

Future<List<Product>> fetchInvoices(http.Client client) async {
  final response = await client
      .get('https://dev-egshops.herokuapp.com/api/invoices/?format=json');

  // Use the compute function to run parseInvoices in a separate isolate.
  return compute(parseInvoices, response.body);
}

// A function that converts a response body into a List<Product>.
List<Product> parseInvoices(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Product>((json) => Product.fromJson(json)).toList();
}

class Product {
  final int user;
  final int order;

  Product({this.user, this.order});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      user: json['user'] as int,
      order: json['order'] as int,
    );
  }
}
