import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentWebView extends StatefulWidget {
  final String url;
  PaymentWebView(this.url);
  @override
  PaymentWebViewState createState() => PaymentWebViewState();
}

class PaymentWebViewState extends State<PaymentWebView> {
  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
          title: Text('Payment'),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: WebView(
          onPageFinished: (page) {
            if (page.contains("success=true")) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.green,
                content: Text('Successfull payment'),
                duration: Duration(seconds: 1),
              ));
            } else if (page.contains("success=false")) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.red,
                content: Text('failed payment'),
                duration: Duration(seconds: 1),
              ));
            }
          },
          initialUrl: widget.url,
          javascriptMode: JavascriptMode.unrestricted,
        ));
  }
}
