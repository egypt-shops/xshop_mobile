import 'package:backdrop/backdrop.dart';
import 'package:flutter/material.dart';
import 'package:xshop_mobile/screens/Cashier/search.dart';

class NewOrder extends StatefulWidget {
  @override
  _NewOrderState createState() => _NewOrderState();
}

class _NewOrderState extends State<NewOrder> {
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
                Tab(icon: Icon(Icons.label_outline)),
              ],
            ),
            body: TabBarView(
              children: [
                Center(child: Text("implement qrscanner hereeee ++++")),
                SearchList(),
              ],
            ),
          )),
      backLayer: Center(
        child: Text("list of added products"),
      ),
    );
  }
}
