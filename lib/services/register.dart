import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

Future<int> register(http.Client client, String name, String mobile,
    String pass1, String pass2) async {
  final response = await client.post(
      Uri.parse("https://dev-egshops.herokuapp.com/api/users/register/"),
      headers: <String, String>{
        "accept": "application/json",
        "Content-Type": "application/json"
      },
      body: jsonEncode(<String, dynamic>{
        "mobile": mobile,
        "name": name,
        "password": pass1,
        "password2": pass2,
      }));
  if (response.statusCode == 200) {
    print('=========================== Registerd ============================');
    return response.statusCode;
  }
  if (response.statusCode == 400 &&
      jsonDecode(response.body)['error']['mobile'][0] != null) {
    return response.statusCode;
  } else {
    throw Exception('failed to register for $mobile');
  }
}
