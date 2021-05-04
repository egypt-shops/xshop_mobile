import 'dart:convert';

import 'package:xshop_mobile/models/invoice.dart';
import 'package:http/http.dart' as http;

Future<Invoice> editInvoices(String id, String user, String order) async {
  int idAsInt = int.parse(id);
  final response = await http.patch(
      Uri.parse('https://dev-egshops.herokuapp.com/api/invoices/$idAsInt/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'user': int.parse(user),
        'order': int.parse(order)
      }));

  if (response.statusCode == 200) {
    return Invoice.fromJson(jsonDecode(response.body));
  } else {
    throw ('failed to load');
  }
}
