import 'package:backdrop/backdrop.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xshop_mobile/screens/Cashier/qrscanner.dart';
import 'package:xshop_mobile/screens/data_entry/product_creating.dart';

class NewOrder extends StatefulWidget {
  @override
  _NewOrderState createState() => _NewOrderState();
}

class _NewOrderState extends State<NewOrder> {
  // make object from scanner
  QRViewScanner _qrViewScanner = QRViewScanner();

  @override
  Widget build(BuildContext context) {
    return BackdropScaffold(
        appBar: BackdropAppBar(
            title: Text(
              "new order",
              style: Theme.of(context).textTheme.bodyText1,
            ),
            actions: <Widget>[
              IconButton(
                  icon: Icon(
                    Icons.payment,
                    color: Colors.white,
                  ),
                  onPressed: () {})
            ]),
        stickyFrontLayer: false,
        frontLayer: DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: TabBar(
                indicatorColor: Theme.of(context).primaryColor,
                tabs: [
                  Tab(icon: Icon(Icons.qr_code)),
                  Tab(icon: Icon(Icons.add_circle)),
                ],
              ),
              body: TabBarView(
                children: [
                  Center(child: _qrViewScanner),
                  ProductCreatingPage(),
                ],
              ),
            )),
        backLayer: Center(
            child: (addedProduct.isEmpty)
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "U don't add any product yet",
                        softWrap: true,
                        style: TextStyle(fontSize: 25.0, color: Colors.white),
                      ),
                      Padding(padding: EdgeInsets.only(top: 30.0)),
                      Icon(
                        Icons.warning_rounded,
                        size: 50.0,
                      )
                    ],
                  )
                : ListView.separated(
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(),
                    itemCount: addedProduct.length,
                    padding: EdgeInsets.all(10.0),
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0))),
                        child: Center(
                            child: Text(
                          ' ${addedProduct[index]}',
                          style: TextStyle(color: Colors.black),
                        )),
                      );
                    })));
  }
}
/*
ListView.builder(
                    padding: EdgeInsets.all(20.0),
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        height: 50,
                        color: Colors.amber,
                        child: Row(
                          children: [
                            Text(' ${addedProduct[0]}'),
                            Text(' ${addedProduct[1]}'),
                            Text(' ${addedProduct[2]}'),
                          ],
                        ),
                      );
                    })
 */
