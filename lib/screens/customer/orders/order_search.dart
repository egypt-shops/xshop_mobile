import 'package:flutter/material.dart';
import 'package:xshop_mobile/models/order.dart';
import 'package:xshop_mobile/screens/customer/shops/shop_details.dart';
import 'package:xshop_mobile/services/search_order.dart';
import 'package:xshop_mobile/services/orders_api.dart';
import 'package:xshop_mobile/theme/apptheme.dart';
import 'package:http/http.dart' as http;

import 'order_detail.dart';

class OrdersSearch extends SearchDelegate {
  Order orderById;
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(
          Icons.close,
          color: AppTheme.colors.secondry,
          size: 30,
        ),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        color: AppTheme.colors.secondry,
        icon: Icon(
          Icons.arrow_back,
          size: 30,
        ),
        onPressed: () => Navigator.pop(context));
  }

  @override
  Widget buildResults(BuildContext context) {
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Center(
        child: Text(
          'search for orders by ID',
          style: TextStyle(fontSize: 18, color: Colors.red),
        ),
      );
    } else {
      return FutureBuilder<Order>(
          future: fetchOrderByID(http.Client(), query),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);

            if (snapshot.hasData) {
              return snapshot.data.exist == 'notFound'
                  ? Center(
                      child: Text(
                        'Not Found',
                        style: TextStyle(fontSize: 18, color: Colors.red[700]),
                      ),
                    )
                  : GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1),
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OrderDetails(
                                  orderData: snapshot.data,
                                ),
                              ),
                            );
                          },
                          child: Card(
                            color: AppTheme.colors.primaryLight,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                            margin: EdgeInsets.fromLTRB(40.0, 40.0, 40.0, 40.0),
                            child: Container(
                              decoration: BoxDecoration(
                                // be the same as radius of card
                                borderRadius: BorderRadius.circular(18.0),
                                border: Border.all(
                                    color: AppTheme.colors.secondry, width: 3),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text('user: ${snapshot.data.user}',
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: AppTheme.colors.primary)),
                                  Text('shop: ${snapshot.data.shop} ',
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.teal[400])),
                                  Text('paid: ${snapshot.data.paid}',
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: AppTheme.colors.secondryDark)),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
            } else
              return Center(child: CircularProgressIndicator());
          });
    }
  }
}
