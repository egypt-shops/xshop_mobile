import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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

class Product {
  final String name;
  final String price;

  Product({this.name, this.price});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'] as String,
      price: json['price'] as String,
    );
  }
}

class ProductPage extends StatelessWidget {
  ProductPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<List<Product>>(
        future: fetchProducts(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? ProductsList(products: snapshot.data)
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class ProductsList extends StatelessWidget {
  final List<Product> products;

  ProductsList({Key key, this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return Card(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
              Text('${products[index].name}',
                  style: TextStyle(fontSize: 20, color: Colors.blue[900])),
              Text('${products[index].price} EGP',
                  style: TextStyle(fontSize: 12, color: Colors.red[900]))
            ]));
      },
    );
  }
}
