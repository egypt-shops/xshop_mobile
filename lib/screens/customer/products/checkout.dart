import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:xshop_mobile/screens/customer/products/payment.dart';
import 'package:xshop_mobile/services/checkout.dart';
import 'package:http/http.dart' as http;

final TextEditingController addressController = new TextEditingController();

class Checkout extends StatefulWidget {
  const Checkout({Key key, this.shopName}) : super(key: key);
  final String shopName;
  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  bool ischeckedout = false;
  bool isloading = false;
  String dropdownValue = 'CREDIT_CARD';
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Checkout', style: TextStyle(color: Colors.grey[700])),
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
                future: checkoutAPI(
                    http.Client(), addressController.text, dropdownValue),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Cheked(
                      checkoutdata: snapshot.data,
                      shopName: widget.shopName,
                    );
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
                              SizedBox(
                                height: 20,
                              ),
                              Row(children: [
                                Text('Payment Method:    ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    )),
                                DropdownButton<String>(
                                  value: dropdownValue,
                                  icon: const Icon(Icons.arrow_downward),
                                  iconSize: 24,
                                  elevation: 16,
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor),
                                  underline: Container(
                                    height: 2,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  onChanged: (String newValue) {
                                    setState(() {
                                      dropdownValue = newValue;
                                    });
                                  },
                                  items: <String>[
                                    'CREDIT_CARD',
                                    'CASH_ON_DELIVERY',
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                )
                              ])
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
  const Cheked({Key key, this.checkoutdata, this.shopName}) : super(key: key);
  final CheckoutData checkoutdata;
  final String shopName;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(20),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                  margin: const EdgeInsets.all(15.0),
                  padding: const EdgeInsets.all(20),
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.grey)),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('shop:              $shopName',
                            style: TextStyle(fontSize: 18)),
                        Text('item count:   ${checkoutdata.itemcount}',
                            style: TextStyle(fontSize: 18)),
                        Text('full price:       ${checkoutdata.fullprice}',
                            style: TextStyle(fontSize: 18)),
                        Text('''address:         ${checkoutdata.address}''',
                            style: TextStyle(fontSize: 18)),
                      ])),
              SizedBox(
                height: 50,
              ),
              Center(
                  child: OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).push(new MaterialPageRoute<Null>(
                            builder: (BuildContext context) {
                              return PaymentWebView(checkoutdata.paymentUrl);
                            },
                            fullscreenDialog: true));
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
