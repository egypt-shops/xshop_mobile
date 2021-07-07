import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

Future<int> register(
    http.Client client, String mobile, String pass1, String pass2) async {
  final response = await client.post(
      Uri.parse("https://dev-egshops.herokuapp.com/api/users/register/"),
      headers: <String, String>{
        "accept": "application/json",
        "Content-Type": "application/json"
      },
      body: jsonEncode(<String, dynamic>{
        "mobile": mobile,
        "pass1": pass1,
        "pass2": pass2,
      }));
  if (response.statusCode == 200) {
    print('=========================== Registerd ============================');
    return response.statusCode;
  } else {
    throw Exception('failed to register for $mobile');
  }
}
