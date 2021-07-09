import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences sharedPreferences;
Future<CheckoutData> checkoutAPI(
    http.Client client, String address, String paymentMethod) async {
  sharedPreferences = await SharedPreferences.getInstance();
  final response = await client.post(
      Uri.parse("https://dev-egshops.herokuapp.com/api/orders/checkout/"),
      headers: <String, String>{
        "accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Token ${sharedPreferences.getString("token")}",
        HttpHeaders.cookieHeader: sharedPreferences.getString("sessionid")
      },
      body: jsonEncode(<String, dynamic>{
        "address": address,
        "paying_method": paymentMethod
      }));
  if (response.statusCode == 200) {
    print('====================== checked out ============================');
    print(response.body);
    return CheckoutData.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('failed to checkout to $address');
  }
}

class CheckoutData {
  final int shoppk;
  final int userpk;
  final int itemcount;
  final String fullprice;
  final String address;
  final String payingMethod;
  final String paymentUrl;

  CheckoutData(
      {this.shoppk,
      this.userpk,
      this.itemcount,
      this.fullprice,
      this.address,
      this.payingMethod,
      this.paymentUrl});

  factory CheckoutData.fromJson(Map<String, dynamic> json) {
    return CheckoutData(
        shoppk: json['order_data']['shop_pk'],
        userpk: json['order_data']['user_pk'],
        itemcount: json['order_data']['item_count'],
        fullprice: json['order_data']['full_price'],
        address: json['address'],
        payingMethod: json["CREDIT_CARD"],
        paymentUrl: json['payment_url']);
  }
}
