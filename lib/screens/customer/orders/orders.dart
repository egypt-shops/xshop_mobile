import 'package:flutter/material.dart';
import 'package:xshop_mobile/models/order.dart';
import 'package:xshop_mobile/screens/customer/orders/order_detail.dart';
import 'package:xshop_mobile/services/orders_api.dart';
import 'package:xshop_mobile/services/search_order.dart';
import 'package:xshop_mobile/theme/apptheme.dart';
import 'package:http/http.dart' as http;

import 'order_search.dart';

class Orders extends StatefulWidget {
  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
                backgroundColor: AppTheme.colors.primary,
                iconTheme: IconThemeData(color: AppTheme.colors.secondry),
                title: Text("Orders"),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.search,
                      size: 30,
                      color: AppTheme.colors.secondry,
                    ),
                    tooltip: 'Search',
                    onPressed: () {
                      showSearch(context: context, delegate: OrdersSearch());
                    },
                  ),
                ]),
            body: OrderApi()));
  }
}

class OrdersList extends StatelessWidget {
  final List<Order> orders;

  OrdersList({Key key, this.orders}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
      return GestureDetector(
          onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OrderDetails(
                    orderData: orders[index],
                  ),
                ),
              ),
          child: Container(
              height: 200,
              padding: EdgeInsets.all(3),
              child: Card(
                  elevation: 5,
                  color: AppTheme.colors.primaryLight,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('user: ${orders[index].user}',
                            style: TextStyle(
                                fontSize: 20, color: AppTheme.colors.primary)),
                        Text('shop: ${orders[index].shop} ',
                            style: TextStyle(
                                fontSize: 15, color: Colors.teal[400])),
                        Text('paid: ${orders[index].paid}',
                            style: TextStyle(
                                fontSize: 20,
                                color: AppTheme.colors.secondryDark)),
                      ]))));
    }, childCount: orders.length));
  }
}
