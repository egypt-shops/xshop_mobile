import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:convert';
import 'package:xshop_mobile/models/product.dart';
import 'dart:convert';

class PostProductQrScanner {
  String qr_result_response;
  String bar_result_response;
  SharedPreferences sharedPreferences;

  Future<String> postProductsBYBarCode(http.Client client, String name,
      String price, String stock, String description) async {
    sharedPreferences = await SharedPreferences.getInstance();

    final response = await (client.post(
        Uri.parse("https://dev-egshops.herokuapp.com/api/products/"),
        headers: <String, String>{
          "accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Token ${sharedPreferences.getString("token")}",
        },
        body: jsonEncode(<String, dynamic>{
          "name": name,
          "price": price,
          "stock": int.parse(stock),
          "description": description
        })));
    print(response.statusCode);
    if (response.statusCode == 200) {
      bar_result_response = 'done';
    } else {
      bar_result_response = 'Wrong';
      // throw ('failed to load');
    }
    return bar_result_response;
  }
}
