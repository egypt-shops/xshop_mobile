import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:xshop_mobile/models/product.dart';
import 'package:http/http.dart' as http;
import 'package:xshop_mobile/screens/customer/products/products.dart';

Future<Product> postProducts(http.Client client, String name, String price,
    String stock, int addedBy) async {
  final response = await client.post(
      Uri.parse("https://dev-egshops.herokuapp.com/api/products/"),
      headers: <String, String>{
        "accept": "application/json",
        "Content-Type": "application/json"
      },
      body: jsonEncode(<String, dynamic>{
        "name": name,
        "price": price,
        "stock": int.parse(stock),
        "added_by": addedBy
      }));

  // Use the compute function to run parseProducts in a separate isolate.
  if (response.statusCode == 200) {
    print('doneeeeeeeeeeeeeeee============================');
    return Product.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('failed to add product for shop $addedBy');
  }
}

Future<List<Product>> fetchProducts(http.Client client, String id) async {
  final response = await client.get(
      Uri.parse('https://dev-egshops.herokuapp.com/api/products/shop/$id/'));

  // Use the compute function to run parseProducts in a separate isolate.
  if (response.statusCode == 200)
    return compute(parseProducts, response.body);
  else {
    throw Exception('failed to load products for shop with id: $id');
  }
}

// A function that converts a response body into a List<Product>.
List<Product> parseProducts(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Product>((json) => Product.fromJson(json)).toList();
}

Future<Product> fetchProductsID(http.Client client, String id) async {
  final response = await client.get(Uri.parse(
      'https://dev-egshops.herokuapp.com/api/products/$id/?format=json'));

  // Use the compute function to run parseProducts in a separate isolate.
  if (response.statusCode == 200)
    return compute(parseProduct, response.body);
  else
    return Product(name: 'notfound', price: '');
}

Product parseProduct(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<String, dynamic>();

  return Product.fromJson(parsed);
}

Future<http.Response> updateProduct(
    String id, String name, String price, int stock, int addedby) async {
  final http.Response response = await http.patch(
      Uri.parse('https://dev-egshops.herokuapp.com/api/products/$id/'),
      headers: <String, String>{
        "accept": " */*",
        "Content-Type": "application/json"
      },
      body: jsonEncode(<String, dynamic>{
        "name": name,
        "price": price,
        "stock": stock,
        "added_by": addedby
      }));
  print(response.statusCode);
  if (response.statusCode == 200) {
    print(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load cart');
  }
  return response;
}
