import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:xshop_mobile/models/product.dart';

class PostProductQrScanner {
  String resultresponse;
  Future<String> postProducts(http.Client client, String QR_Result) async {
    final response = await client.post(
        Uri.parse("https://dev-egshops.herokuapp.com/api/products/"),
        headers: <String, String>{
          "accept": "application/json",
          "Content-Type": "application/json"
        },
        body: QR_Result);
    if (response.statusCode == 200) {
      resultresponse = 'done';
    } else {
      resultresponse = 'Wrong';
      throw ('failed to load');
    }
    return resultresponse;
  }
}
