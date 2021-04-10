import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:xshop_mobile/models/shop.dart';
import 'package:xshop_mobile/screens/customer/products/products.dart';
import 'package:xshop_mobile/theme/apptheme.dart';

class ShopDetails extends StatelessWidget {
  final Shop shop;
  ShopDetails({key, this.shop}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: 30,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(
              context,
            );
          },
        ),
        title: Text(
          shop.name,
          style: TextStyle(
            color: AppTheme.colors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage('images/meeting.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.fromLTRB(30.0, 20.0, 15.0, 0),
              child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Container(
                      child: Column(
                        children: [
                          Text(
                            shop.name,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          Text(
                            'Egypt,  Cairo',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w200),
                          ),
                        ],
                        crossAxisAlignment: CrossAxisAlignment.start,
                      ),
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Icon(
                          Icons.star,
                          size: 30,
                          color: Colors.orange,
                        ),
                        Text('88'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            flex: 2,
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.fromLTRB(20.0, 0, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Icon(
                        Icons.call,
                        color: AppTheme.colors.primary,
                      ),
                      Text(
                        'CALL',
                        style: TextStyle(
                          color: AppTheme.colors.primary,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Icon(
                        Icons.transit_enterexit_outlined,
                        color: AppTheme.colors.primary,
                      ),
                      Text(
                        'ROUTE',
                        style: TextStyle(
                          color: AppTheme.colors.primary,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Icon(
                        Icons.share_outlined,
                        color: AppTheme.colors.primary,
                      ),
                      Text(
                        'SHARE',
                        style: TextStyle(
                          color: AppTheme.colors.primary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 30, 20.0, 0),
              child: Text(
                shop.name +
                    '  '
                        ' is shop that provides a lot of products '
                        'this is shop that provides a lot of products '
                        'this is shop that provides a lot of products '
                        'this is shop that provides a lot of products '
                        'this is shop that provides a lot of products '
                        'this is shop that provides a lot of products '
                        'this is shop that provides a lot of products '
                        'this is shop that provides a lot of products '
                        'this is shop that provides a lot of products ',
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 12.0, color: Colors.black),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Products(
                                  shopId: shop.id.toString(),
                                )),
                      );
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.orange)),
                    child: Text(
                      'Our Products',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    )),
                SizedBox(
                  width: 15.0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
