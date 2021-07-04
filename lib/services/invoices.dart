import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xshop_mobile/models/invoice.dart';
import '../models/invoice.dart';
import '../screens/customer/invoices/invoices.dart';

class InvoiceApi extends StatelessWidget {
  InvoiceApi({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<List<Invoice>>(
          future: fetchInvoices(http.Client()),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return InvoicesList(invoices: snapshot.data);
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            } else {
              return SliverToBoxAdapter(
                  child: Center(
                      child: SizedBox(
                          height: 200,
                          width: 200,
                          child: Center(child: CircularProgressIndicator()))));
            }
          }),
    );
  }
}

Future<List<Invoice>> fetchInvoices(http.Client client) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  final response = await client.get(
      Uri.parse('https://dev-egshops.herokuapp.com/api/invoices/'),
      headers: <String, String>{
        "accept": " */*",
        "Content-Type": "application/json",
        "Authorization": "Token ${sharedPreferences.getString("token")}",
      });
  if (response.statusCode == 200) {
    // Use the compute function to run parsePhotos in a separate isolate.
    return compute(parseInvoices, response.body);
  } else {
    throw Exception('failed to load shop');
  }
}

// A function that converts a response body into a List<Invoice>.
List<Invoice> parseInvoices(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Invoice>((json) => Invoice.fromJson(json)).toList();
}
