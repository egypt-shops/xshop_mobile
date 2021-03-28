import 'dart:convert';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xshop_mobile/screens/customer/shops.dart';

class ShopApi extends StatelessWidget {
  ShopApi({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<List<Shop>>(
          future: fetchShops(http.Client()),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ShopList(shops: snapshot.data);
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            } else {
              return CircularProgressIndicator();
            }
          }),
    );
  }
}

//make class
class Shop {
  final String name;

  Shop({this.name});

  factory Shop.fromJson(Map<String, dynamic> json) {
    return Shop(
      name: json['name'] as String,
    );
  }
}

// A function that converts a response body into a List<Product>.
List<Shop> parseShop(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Shop>((json) => Shop.fromJson(json)).toList();
}

// fetch shops
Future<List<Shop>> fetchShops(http.Client client) async {
  final response = await client
      .get('https://dev-egshops.herokuapp.com/api/shops/?format=json');
  if (response.statusCode == 200) {
    // Use the compute function to run parsePhotos in a separate isolate.
    return compute(parseShop, response.body);
  } else {
    throw Exception('failed to load shop');
  }
}
