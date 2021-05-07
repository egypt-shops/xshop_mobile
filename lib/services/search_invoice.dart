import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:xshop_mobile/models/invoice.dart';

Future<Invoice> fetchInvoicesID(http.Client client, String id) async {
  final response = await client.get(Uri.parse(
      'https://dev-egshops.herokuapp.com/api/invoices/$id/?format=json'));

  // Use the compute function to run parseInvoices in a separate isolate.
  if (response.statusCode != 200)
    return Invoice(user: 0, order: 0);
  else
    return compute(parseInvoice, response.body);
}

Invoice parseInvoice(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<String, dynamic>();

  return Invoice.fromJson(parsed);
}
