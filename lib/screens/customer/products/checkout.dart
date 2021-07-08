import 'package:flutter/material.dart';
import 'package:xshop_mobile/screens/customer/products/payment.dart';
import 'package:xshop_mobile/services/checkout.dart';
import 'package:http/http.dart' as http;

final TextEditingController addressController = new TextEditingController();

class Checkout extends StatefulWidget {
  const Checkout({Key key}) : super(key: key);

  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  bool ischeckedout = false;
  bool isloading = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Checkout'),
            backgroundColor: Colors.transparent,
            elevation: 0, // 1

            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios,
                  color: Theme.of(context).primaryColor),
              onPressed: () {
                Navigator.pop(context);
              },
            )),
        body: ischeckedout
            ? FutureBuilder<CheckoutData>(
                future: checkoutAPI(http.Client(), addressController.text),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Cheked(checkoutdata: snapshot.data);
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  } else {
                    return Center(
                        child: SizedBox(
                            height: 200,
                            width: 200,
                            child: Center(child: CircularProgressIndicator())));
                  }
                })
            : Padding(
                padding: EdgeInsets.all(20),
                child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Enter your address: '),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "address can not be empty";
                                    }

                                    return null;
                                  },
                                  controller: addressController,
                                  autofocus: true,
                                  maxLength: 100,
                                  keyboardType: TextInputType.text,
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder())),
                            ]),
                        Center(
                            child: OutlinedButton(
                                onPressed: () {
                                  if (_formKey.currentState.validate()) {
                                    setState(() {
                                      ischeckedout = true;
                                    });
                                  }
                                },
                                child: Text(
                                  'Checkout',
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor),
                                )))
                      ],
                    )),
              ));
  }
}

class Cheked extends StatelessWidget {
  const Cheked({Key key, this.checkoutdata}) : super(key: key);
  final CheckoutData checkoutdata;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(20),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('shop:             ${checkoutdata.shoppk}'),
                Text('item count:   ${checkoutdata.itemcount}'),
                Text('full price:      ${checkoutdata.fullprice}'),
                Text('address:        ${checkoutdata.address}'),
              ]),
              SizedBox(
                height: 50,
              ),
              Center(
                  child: OutlinedButton(
                      onPressed: () {
                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                elevation: 5,
                                backgroundColor: Theme.of(context).primaryColor,
                                title: Text('test webview for payment',
                                    style:
                                        Theme.of(context).textTheme.bodyText1),
                                content: WebViewExample(),
                                actions: <Widget>[
                                  OutlinedButton(
                                    
                                      child: new Text(
                                        "Cancel",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 15),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      })
                                ],
                              );
                            });
                      },
                      child: Text(
                        'Pay',
                        style: TextStyle(
                            fontSize: 20,
                            color: Theme.of(context).primaryColor),
                      )))
            ]));
  }
}
