import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:xshop_mobile/main.dart';
import 'package:xshop_mobile/screens/home/home.dart';

class PaymentWebView extends StatefulWidget {
  final String url;
  PaymentWebView(this.url);
  @override
  PaymentWebViewState createState() => PaymentWebViewState();
}

class PaymentWebViewState extends State<PaymentWebView> {
  bool isPaid = false;
  bool isSuccess = false;
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
          title: !isPaid
              ? Text('Payment', style: TextStyle(color: Colors.grey[700]))
              : Text(isSuccess ? 'Successful payment' : 'Unsuccessful payment',
                  style: TextStyle(color: Colors.grey[700])),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: isPaid
            ? Container(
                child: isSuccess ? SuccessfulPayment() : UnSuccessfulPayment())
            : WebView(
                onPageFinished: (page) {
                  if (page.contains("success=true")) {
                    setState(() {
                      isPaid = true;
                      isSuccess = true;
                    });
                    sharedPreferences.remove('sessionid');
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.green,
                      content: Text('Successfull payment'),
                      duration: Duration(seconds: 1),
                    ));
                  } else if (page.contains("success=false")) {
                    setState(() {
                      isPaid = true;
                      isSuccess = false;
                    });
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

class SuccessfulPayment extends StatelessWidget {
  const SuccessfulPayment({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
            padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text('''Successful payment''',
                        style: TextStyle(color: Colors.green[600])),
                    Padding(
                        padding: EdgeInsets.all(10),
                        child: Icon(
                          Icons.check,
                          color: Colors.green[600],
                        ))
                  ]),
                  Text('''your order has been created.'''),
                ])),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Row(children: [
            TextButton(
                onPressed: () {},
                child: Text(
                  'Rate this shop',
                  style: TextStyle(color: Colors.grey[600]),
                )),
            Icon(
              Icons.star,
              color: Colors.amber[300],
            )
          ]),
          OutlinedButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (BuildContext context) => Home()),
                );
              },
              child: Text(
                'Back to Home',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ))
        ])
      ],
    );
  }
}

class UnSuccessfulPayment extends StatelessWidget {
  const UnSuccessfulPayment({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
            padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Text('''failed payment''',
                    style: TextStyle(color: Colors.red[600])),
                Padding(
                    padding: EdgeInsets.all(10),
                    child: Icon(
                      Icons.sentiment_dissatisfied,
                      color: Colors.grey,
                    ))
              ]),
              Text(
                  '''make sure that your card credentials is valid or contact support to report a problem.'''),
            ])),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          TextButton(
              onPressed: () {},
              child: Text(
                'Contact support?',
                style: TextStyle(color: Colors.blue[400]),
              )),
          OutlinedButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (BuildContext context) => Home()),
                );
              },
              child: Text(
                'Back to Home',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ))
        ])
      ],
    );
  }
}
