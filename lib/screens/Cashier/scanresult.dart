import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:xshop_mobile/models/product.dart';
import 'package:xshop_mobile/screens/data_entry/qrscanner.dart';

class ScanResult extends StatelessWidget {
  final String resultresponse;
  ScanResult({this.resultresponse});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RESULT'),
      ),
      body: Center(
        child: Text('Data is $resultresponse'),
      ),
    );
  }
}
