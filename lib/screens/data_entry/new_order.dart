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
                        style: TextStyle(fontSize: 15.0, color: Colors.white),
                      ),
                      Padding(padding: EdgeInsets.only(top: 15.0)),
                      Icon(
                        Icons.warning_rounded,
                        size: 35.0,
                      )
                    ],
                  )
                : ListView.separated(
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(),
                    itemCount: addedProduct.length,
                    padding: EdgeInsets.all(5.0),
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        child: ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${addedProduct[index].split(',')[0]}'
                                        .toUpperCase(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 17),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 3.0),
                                  ),
                                  Text(
                                    'QUANTITY IS   : ${quantity[index]}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 4.0),
                                  ),
                                  Text(
                                    'TOTAL PRICE IS ${addedProduct[index].split(',')[1]}' +
                                        ' \$',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15),
                                  ),
                                ],
                              ),
                              Container(
                                alignment: Alignment.topCenter,
                                child: Icon(
                                  Icons.done,
                                  color: Colors.black,
                                  size: 25,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    })));
  }

  Card listProduct(String product, String price) {
    return Card(
      child: ListTile(
        title: Text('${addedProduct[0][0]}'),
        subtitle: Text('${addedProduct[0][1]}' + '\$'),
      ),
    );
  }
}
/*
Container(
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
                      )
*/
