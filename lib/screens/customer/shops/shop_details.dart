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
        backgroundColor: AppTheme.colors.primary,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: 30,
            color: AppTheme.colors.secondry,
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
      body: ListView(
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage('images/try.jpg'),
                fit: BoxFit.cover,
              ),
              border: Border.all(
                color: Colors.teal[900],
                width: 8,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'this is shop that provides a lot of products'
              'this is shop that provides a lot of products'
              'this is shop that provides a lot of products'
              'this is shop that provides a lot of products'
              'this is shop that provides a lot of products'
              'this is shop that provides a lot of products'
              'this is shop that provides a lot of products',
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 15.0, color: Colors.teal.shade900),
            ),
          ),
          Card(
            margin: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 10.0),
            color: Colors.teal[100],
            child: Column(children: [
              Text(
                'our rate'.toUpperCase(),
                textAlign: TextAlign.center,
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.teal),
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.star,
                    size: 20.0,
                    color: Colors.white,
                  ),
                  Icon(
                    Icons.star,
                    size: 20.0,
                    color: Colors.white,
                  ),
                  Icon(
                    Icons.star,
                    size: 20.0,
                    color: Colors.white,
                  ),
                  Icon(
                    Icons.star,
                    size: 20.0,
                    color: Colors.black,
                  ),
                  Icon(
                    Icons.star,
                    size: 20.0,
                    color: Colors.black,
                  ),
                ],
              ),
            ]),
          ),
          Row(
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
                  child: Text(
                    'Our Products',
                    style: TextStyle(
                      color: Colors.teal[100],
                    ),
                  )),
              SizedBox(
                width: 15.0,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
