import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:xshop_mobile/models/product.dart';
import 'package:http/http.dart' as http;

Future<List<Product>> fetchProducts(http.Client client) async {
  final response = await client
      .get('https://dev-egshops.herokuapp.com/api/products/?format=json');

  // Use the compute function to run parseProducts in a separate isolate.
  return compute(parseProducts, response.body);
}

// A function that converts a response body into a List<Product>.
List<Product> parseProducts(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Product>((json) => Product.fromJson(json)).toList();
}

/*
class ProductPage extends StatelessWidget {
  ProductPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return 
  }
}
*/
