import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:http/http.dart' as http;

import 'package:xshop_mobile/services/post_product_by_scanning.dart';

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
  int check = 0;
  QRViewController controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
              flex: 4,
              child: (check == 0)
                  ? _buildQrView(context)
                  : (resultresponse == 'done')
                      ? Center(
                          child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text(
                                'Adding Product'
                                        ' is ' +
                                    resultresponse,
                                style: TextStyle(fontSize: 25.0),
                              ),
                            ),
                            Icon(
                              Icons.done_outline_sharp,
                              size: 50,
                              color: Colors.blue,
                            )
                          ],
                        ))
                      : Center(
                          child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Adding Product'
                                      ' is\n' +
                                  resultresponse,
                              style: TextStyle(fontSize: 25.0),
                            ),
                            Icon(
                              Icons.error_outline,
                              size: 50,
                              color: Colors.red,
                            )
                          ],
                        ))),
          Expanded(
            flex: 1,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextButton(
                      child: Text(
                        'Scan Barcode again',
                      ),
                      onPressed: () {
                        setState(() {
                          controller.resumeCamera();
                          check = 0;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          )
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
      check = 1;
      await controller.pauseCamera();

      resultresponse =
          await _postProductQrScanner.postProducts(http.Client(), result.code);
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
