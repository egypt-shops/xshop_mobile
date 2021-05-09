import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:xshop_mobile/screens/Cashier/qrscanner.dart';

class ScanResult extends StatelessWidget {
  final Barcode result;
  ScanResult({this.result});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RESULT'),
      ),
      body: Center(
        child: Text('Data is ${result.code.codeUnits}'),
      ),
    );
  }
}
