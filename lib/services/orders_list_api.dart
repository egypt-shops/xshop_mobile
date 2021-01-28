import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class OrdersApi extends StatelessWidget {
  OrdersApi({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<List<Orders>>(
            future: fetchOrders(http.Client()),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print(snapshot.data);
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1.2,
                  ),
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return SafeArea(
                      child: Container(
                        color: Colors.teal.shade800,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(snapshot.data[index].id.toString(),
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 18,
                                )),
                            Text(
                              snapshot.data[index].id.toString(),
                            ),
                            Text(
                              snapshot.data[index].user.toString(),
                            ),
                            Text(
                              snapshot.data[index].shop.toString(),
                            ),
                            Text(
                              snapshot.data[index].paid.toString(),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              } else {
                return CircularProgressIndicator();
              }
            }),
      ),
    );
  }
}

Future<List<Orders>> fetchOrders(http.Client client) async {
  final response =
      await client.get('https://dev-egshops.herokuapp.com/api/orders/');
  if (response.statusCode == 200) {
    return compute(parseOrders, response.body);
  } else {
    throw Exception('failed to load orders');
  }
}

// convert orders to list
List<Orders> parseOrders(String responseBody) {
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
      id: json['id'] as int,
      user: json['user'] as int,
      shop: json['shop'] as int,
      paid: json['paid'] as bool,
    );
  }
}
