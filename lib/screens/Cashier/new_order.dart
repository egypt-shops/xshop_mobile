import 'package:backdrop/backdrop.dart';
import 'package:flutter/material.dart';
import 'package:xshop_mobile/screens/Cashier/cashierScanner.dart';
import 'package:xshop_mobile/screens/Cashier/payment.dart';
import 'package:xshop_mobile/screens/Cashier/search.dart';
import 'package:xshop_mobile/screens/customer/products/checkout.dart';
import 'cashierScanner.dart';

class NewOrder extends StatefulWidget {
  @override
  _NewOrderState createState() => _NewOrderState();
}

class _NewOrderState extends State<NewOrder> {
  // make object from scanner
  CashierScanner _cashierScanner = CashierScanner();
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
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CashierPayment(
                          shopName: "cashier",
                        ),
                      ),
                    );
                  }),
            ]),
        stickyFrontLayer: false,
        frontLayer: DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: TabBar(
                indicatorColor: Theme.of(context).primaryColor,
                tabs: [
                  Tab(icon: Icon(Icons.qr_code)),
                  Tab(icon: Icon(Icons.label_outline)),
                ],
              ),
              body: TabBarView(
                children: [
                  Center(child: _cashierScanner),
                  SearchList(),
                ],
              ),
            )),
        backLayer: Center(
            child: (gettingProducts.isEmpty)
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "U don't get any product yet",
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
                    itemCount: gettingProducts.length,
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
                                    '${gettingProducts[index].name}'
                                        .toUpperCase(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 17),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 3.0),
                                  ),
                                  Text(
                                    'QUANTITY IS   : ${gettingProducts[index].stock}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 4.0),
                                  ),
                                  Text(
                                    'TOTAL PRICE IS ${gettingProducts[index].price}' +
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
}
