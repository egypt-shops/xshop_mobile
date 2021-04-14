import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:xshop_mobile/models/product.dart';

Future<Product> fetchProductsID(http.Client client, String id) async {
  final response = await client
      .get('https://dev-egshops.herokuapp.com/api/products/$id/?format=json');

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
