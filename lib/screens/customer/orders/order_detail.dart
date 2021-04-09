import 'package:flutter/material.dart';
import 'package:xshop_mobile/models/order.dart';

class OrderDetails extends StatelessWidget {
  final Order orderData;

  OrderDetails({this.orderData});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details'),
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Text(orderData.user.toString()),
            Text(orderData.shop.toString()),
            Text(orderData.paid.toString()),
          ],
        ),
      ),
    );
  }
}
