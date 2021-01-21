import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:xshop_mobile/screens/customer/elmasry.dart';
import 'package:xshop_mobile/screens/data_entry/main_of_data_entry.dart';
import 'package:xshop_mobile/services/shop_api.dart';

class ShopPage extends StatefulWidget {
  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.teal,
        appBar: AppBar(
          backgroundColor: Colors.teal,
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
            'Shops',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
                icon: Icon(
                  Icons.search,
                  size: 30,
                  color: Colors.white,
                ),
                tooltip: 'search',
                onPressed: null)
          ],
        ),
        body: ShopApi(),
      ),
    );
  }
}

//
class ShopList extends StatelessWidget {
  final List<Shop> shops;
  ShopList({Key key, this.shops}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: shops.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ShopDetails(shop: shops[index])),
              );
            },
            child: Card(
              margin: EdgeInsets.fromLTRB(4.0, 10.0, 4.0, 0.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '${shops[index].name}',
                    style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.teal,
                        fontWeight: FontWeight.bold),
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
                        color: Colors.teal.shade300,
                      ),
                      Icon(
                        Icons.star,
                        size: 20.0,
                        color: Colors.teal.shade300,
                      ),
                      Icon(
                        Icons.star,
                        size: 20.0,
                        color: Colors.teal.shade300,
                      ),
                      Icon(
                        Icons.star,
                        size: 20.0,
                        color: Colors.teal.shade300,
                      ),
                      Icon(
                        Icons.star,
                        size: 20.0,
                        color: Colors.teal.shade300,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
