import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:http/http.dart' as http;

import 'package:xshop_mobile/services/post_product_by_scanning.dart';

// list of added products
Barcode result;
List addedProduct = [];

class QRViewScanner extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _QRViewScannerState();
}

class _QRViewScannerState extends State<QRViewScanner> {
  // response of post request
  String resultresponse;
  // make object from postproductqrscanner
  PostProductQrScanner _postProductQrScanner = PostProductQrScanner();
  Barcode result;
  QRViewController controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 250.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });

    controller.scannedDataStream.listen((scanData) async {
      result = scanData;
      List<String> barResult = result.code.split(",");
      await controller.pauseCamera();
      resultresponse = await _postProductQrScanner.postProductsBYBarCode(
          http.Client(),
          barResult[0],
          barResult[1],
          barResult[2],
          barResult[3]);
      if (resultresponse == 'done') {
        addedProduct
            .add(barResult[0] + ' is added ' + '& its price ' + barResult[1]);
      }

      Future.delayed(Duration(milliseconds: 300), () async {
        await controller.resumeCamera();
      });
      // resultresponse =
      //     await _postProductQrScanner.postProducts(http.Client(), result.code);
      // Future.delayed(Duration(milliseconds: 300), () async {
      //   await controller.resumeCamera();
      // });

      final snackBar = SnackBar(
        content: Text('Adding product is $resultresponse'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            // Some code to undo the change.
          },
        ),
      );
      // Find the ScaffoldMessenger in the widget tree
      // and use it to show a SnackBar.
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      setState(() {});
    });
  }
//
// @override
// void dispose() {
//   controller.dispose();
//   super.dispose();
// }
}
