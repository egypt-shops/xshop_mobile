import 'package:flutter/material.dart';
import 'package:xshop_mobile/models/order.dart';
import 'package:xshop_mobile/services/search_order.dart';
import 'package:http/http.dart' as http;

class GetOrder extends StatelessWidget {
  GetOrder(this.id);
  final int id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: FutureBuilder<Order>(
            future: fetchOrderByID(http.Client(), id.toString()),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return OrderDetails(orderData: snapshot.data);
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

class OrderDetails extends StatelessWidget {
  final Order orderData;

  OrderDetails({this.orderData});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(orderData.user.toString()),
          Text(orderData.shop.toString()),
          Text(orderData.paid.toString()),
        ],
      ),
    );
  }
}
