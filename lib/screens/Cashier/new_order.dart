import 'package:backdrop/backdrop.dart';
import 'package:flutter/material.dart';

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
      frontLayer: Center(
        child: Text("implement barcode scanner & add by id"),
      ),
      backLayer: Center(
        child: Text("list of added products"),
      ),
    );
  }
}
