import 'dart:convert';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:xshop_mobile/services/shop_api.dart';

Future<Shop> fetchShopByID(http.Client client, String id) async {
  final response = await http
      .get('https://dev-egshops.herokuapp.com/api/shops/$id/?format=json');
  if (response.statusCode == 200) {
    return compute(parsedShop, response.body);
  } else {
    return Shop(name: 'notFound');
  }
}

Shop parsedShop(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<String, dynamic>();
  return Shop.fromJson(parsed);
}
