import 'package:flutter/material.dart';
import 'package:xshop_mobile/models/order.dart';
import 'package:xshop_mobile/screens/customer/orders/order_detail.dart';
import 'package:xshop_mobile/services/orders_api.dart';
import 'package:xshop_mobile/services/search_order.dart';
import 'package:xshop_mobile/theme/apptheme.dart';
import 'package:http/http.dart' as http;
import 'package:xshop_mobile/tmp/patch_orders.dart';

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
          // onTap: () => Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => GetOrder(
          //           orders[index].id,
          //         ),
          //       ),
          //     ),
          child: Container(
              padding: EdgeInsets.all(3),
              child: Card(
                  elevation: 2,
                  color: AppTheme.colors.primaryLight,
                  child: Container(
                      padding: EdgeInsets.symmetric(vertical: 4),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.blueGrey,
                          child: Text('${orders[index].user}'),
                        ),
                        title: Text('user: ${orders[index].user}'),
                        subtitle: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('shop: ${orders[index].shop}'),
                            Padding(padding: EdgeInsets.only(left: 10)),
                            Text("Paid:"),
                            Icon(
                              orders[index].paid.toString() == 'true'
                                  ? Icons.done
                                  : Icons.close,
                              size: 16,
                              color: AppTheme.colors.secondryDark,
                            )
                          ],
                        ),
                        // trailing: CircleAvatar(
                        //     backgroundColor: Colors.grey.shade300,
                        //     child: IconButton(
                        //       icon: Icon(
                        //         Icons.edit,
                        //         size: 18,
                        //         color: AppTheme.colors.primaryDark,
                        //       ),
                        //       onPressed: () {
                        //         Navigator.push(
                        //           context,
                        //           MaterialPageRoute(
                        //               builder: (context) =>
                        //                   UpdateOrders(id: orders[index].id)),
                        //         );
                        //       },
                        //     ))
                      ))

                  // Column(
                  //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //     crossAxisAlignment: CrossAxisAlignment.center,
                  //     children: [
                  //       Text('user: ${orders[index].user}',
                  //           style: TextStyle(
                  //               fontSize: 20, color: AppTheme.colors.primary)),
                  //       Text('shop: ${orders[index].shop} ',
                  //           style: TextStyle(
                  //               fontSize: 15, color: Colors.teal[400])),
                  //       Text('paid: ${orders[index].paid}',
                  //           style: TextStyle(
                  //               fontSize: 20,
                  //               color: AppTheme.colors.secondryDark)),
                  //     ])

                  )));
    }, childCount: orders.length));
  }
}
