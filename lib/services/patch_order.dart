import 'dart:convert';

import 'package:xshop_mobile/models/order.dart';
import 'package:http/http.dart' as http;

Future<Order> modifyOrder(
  String id,
  String user,
  String shop,
  bool paid,
) async {
  final response = await http.patch(
      Uri.parse('https://dev-egshops.herokuapp.com/api/orders/$id/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'user': int.parse(user),
        'shop': int.parse(shop),
        'paid': paid,
      }));
  print("$id \n $user \n $shop \n $paid");
  print(response.statusCode.toString() + "\n ${response.body}");
  if (response.statusCode == 200) {
    return Order.fromJson(jsonDecode(response.body));
  } else {
    throw ('failed to load');
  }
}
