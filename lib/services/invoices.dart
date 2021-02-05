import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:xshop_mobile/models/invoice.dart';

Future<List<Invoice>> fetchInvoices(http.Client client) async {
  final response = await client
      .get('https://dev-egshops.herokuapp.com/api/invoices/?format=json');

  // Use the compute function to run parseInvoices in a separate isolate.
  return compute(parseInvoices, response.body);
}

// A function that converts a response body into a List<Invoice>.
List<Invoice> parseInvoices(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Invoice>((json) => Invoice.fromJson(json)).toList();
}
