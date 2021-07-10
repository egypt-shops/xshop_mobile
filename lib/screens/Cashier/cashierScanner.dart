import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:xshop_mobile/models/product.dart';
import 'package:xshop_mobile/services/post_product_by_scanning.dart';
import 'package:xshop_mobile/models/sound_manager.dart';
import 'package:xshop_mobile/services/products.dart';

// list of added products
String result; // productId
// list of products that get it by scan qr code
List<Product> gettingProducts = [];

class CashierScanner extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CashierScannerState();
}

class _CashierScannerState extends State<CashierScanner> {
  // response of post request
  String resultresponse;
  // make object from postproductqrscanner
  PostProductQrScanner _postProductQrScanner = PostProductQrScanner();
  Barcode result;
  QRViewController controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

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

      await controller.stopCamera();

      SoundManager soundManager = new SoundManager();
      soundManager.playLocal("sou.mp3").then((onValue) {});

      Product p = await fetchProductsID(http.Client(), result.code.toString());
      // to check if there is error while getting product
      if (p.name != 'notfound') {
        gettingProducts.add(p);
        final snackBar = SnackBar(
          content: Text('Getting product is correct'),
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
      } else {
        final snackBar = SnackBar(
          content: Text('Getting product is wrong'),
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
      }
      await controller.resumeCamera();

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
