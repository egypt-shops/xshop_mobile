import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:xshop_mobile/models/product.dart';
import 'dart:convert';

class PostProductQrScanner {
  String qr_result_response;
  String bar_result_response;

  Future<String> postProductsByQR(http.Client client, String QR_Result) async {
    final response = await client.post(
        Uri.parse("https://dev-egshops.herokuapp.com/api/products/"),
        headers: <String, String>{
          "accept": "application/json",
          "Content-Type": "application/json"
        },
        body: QR_Result);
    if (response.statusCode == 200) {
      qr_result_response = 'done';
    } else {
      qr_result_response = 'Wrong';
      throw ('failed to load');
    }
    return qr_result_response;
  }

  Future<String> postProductsBYBarCode(http.Client client, String name,
      String price, String stock, String addedBy) async {
    final response = await (client.post(
        Uri.parse("https://dev-egshops.herokuapp.com/api/products/"),
        headers: <String, String>{
          "accept": "application/json",
          "Content-Type": "application/json"
        },
        body: jsonEncode(<String, dynamic>{
          "name": name,
          "price": price,
          "stock": int.parse(stock),
          "added_by": int.parse(addedBy)
        })));
    if (response.statusCode == 200) {
      bar_result_response = 'done';
    } else {
      bar_result_response = 'Wrong';
      // throw ('failed to load');
    }
    return bar_result_response;
  }
}
