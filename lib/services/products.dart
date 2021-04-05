import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:xshop_mobile/models/product.dart';
import 'package:http/http.dart' as http;
import 'package:xshop_mobile/screens/customer/products/products.dart';

class ProductApi extends StatelessWidget {
  final String id;
  ProductApi({Key key, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
        future: fetchProducts(http.Client(), id),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ProductsList(products: snapshot.data);
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          } else {
            return SizedBox(
                height: 200,
                width: 200,
                child: Center(child: CircularProgressIndicator()));
          }
        });
  }
}

Future<List<Product>> fetchProducts(http.Client client, String id) async {
  final response = await client
      .get('https://dev-egshops.herokuapp.com/api/products/shop/$id/');

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
