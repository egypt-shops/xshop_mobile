import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'file:///C:/Users/ahmed/Downloads/Documents/mobile/xshop_mobile/lib/screens/customer/shop_search.dart';
import 'package:xshop_mobile/screens/customer/shop_details.dart';
import 'package:xshop_mobile/services/shop_api.dart';
import 'package:xshop_mobile/theme/apptheme.dart';

class ShopPage extends StatefulWidget {
  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
            'Shops',
            style: TextStyle(
              color: AppTheme.colors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.search,
                size: 30,
                color: AppTheme.colors.secondry,
              ),
              tooltip: 'search',
              onPressed: () {
                showSearch(context: context, delegate: ShopsSearch());
              },
            )
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
              color: AppTheme.colors.primaryLight,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              margin: EdgeInsets.fromLTRB(4.0, 10.0, 4.0, 0.0),
              child: Container(
                decoration: BoxDecoration(
                  // be the same as radius of card
                  borderRadius: BorderRadius.circular(18.0),
                  border: Border.all(color: AppTheme.colors.secondry, width: 3),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '${shops[index].name}',
                      style: TextStyle(
                          fontSize: 20.0,
                          color: AppTheme.colors.primary,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      '${shops[index].name}',
                      style: TextStyle(
                          fontSize: 20.0,
                          color: AppTheme.colors.primary,
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
            ),
          );
        });
  }
}
