import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xshop_mobile/models/order.dart';
import 'package:xshop_mobile/screens/customer/orders/orders.dart';

class OrderApi extends StatelessWidget {
  OrderApi({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<List<Order>>(
          future: fetchOrders(http.Client()),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return OrdersList(orders: snapshot.data);
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            } else {
              return SliverToBoxAdapter(
                  child: Center(
                      child: SizedBox(
                          height: 200,
                          width: 200,
                          child: Center(child: CircularProgressIndicator()))));
            }
          }),
    );
  }
}

Future<List<Order>> fetchOrders(http.Client client) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  final response = await client.get(
      Uri.parse('https://dev-egshops.herokuapp.com/api/orders/?format=json'),
      headers: <String, String>{
        "accept": " */*",
        "Content-Type": "application/json",
        "Authorization": "Token ${sharedPreferences.getString("token")}",
      });

  // Use the compute function to run parseOrders in a separate isolate.
  return compute(parseOrders, response.body);
}

// A function that converts a response body into a List<Product>.
List<Order> parseOrders(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Order>((json) => Order.fromJson(json)).toList();
}
