import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:xshop_mobile/screens/Cashier/printer.dart';
import 'package:xshop_mobile/screens/customer/products/payment.dart';
import 'package:xshop_mobile/screens/home/components/cashier.dart';
import 'package:xshop_mobile/screens/home/home.dart';
import 'package:xshop_mobile/services/checkout.dart';
import 'package:http/http.dart' as http;

class CashierPayment extends StatelessWidget {
  const CashierPayment({Key key, this.shopName}) : super(key: key);

  final String shopName;

  @override
  Widget build(BuildContext context) {
    CheckoutData checkoutdata;
    return Scaffold(
        appBar: AppBar(
            title: Text('order details',
                style: TextStyle(color: Colors.grey[700])),
            backgroundColor: Colors.transparent,
            elevation: 0, // 1

            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios,
                  color: Theme.of(context).primaryColor),
              onPressed: () {
                Navigator.pop(context);
              },
            )),
        body: FutureBuilder<CheckoutData>(
            future: checkoutAPI(http.Client(), 'Cashier', 'CASH_ON_DELIVERY'),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                checkoutdata = snapshot.data;
                return Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                              margin: const EdgeInsets.all(15.0),
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey)),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('shop:              boyka $shopName',
                                        style: TextStyle(fontSize: 18)),
                                    Text(
                                        'item count:   ${checkoutdata.itemcount}',
                                        style: TextStyle(fontSize: 18)),
                                    Text(
                                        'full price:       ${checkoutdata.fullprice}',
                                        style: TextStyle(fontSize: 18)),
                                  
                                  ])),
                          SizedBox(
                            height: 50,
                          ),
                          Center(
                              child: OutlinedButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .push(new MaterialPageRoute<Null>(
                                            builder: (BuildContext context) {
                                              return Printer(checkoutdata);
                                            },
                                            fullscreenDialog: true));
                                  },
                                  child: Container(
                                      width: 150,
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Print receipt',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                            ),
                                            Icon(Icons.receipt,
                                                color: Theme.of(context)
                                                    .primaryColor)
                                          ]))))
                        ]));
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              } else {
                return Center(
                    child: SizedBox(
                        height: 200,
                        width: 200,
                        child: Center(child: CircularProgressIndicator())));
              }
            }));
  }
}
