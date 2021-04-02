import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:xshop_mobile/screens/customer/shop_search.dart';
import 'package:xshop_mobile/screens/customer/shop_details.dart';
import 'package:xshop_mobile/services/shop_api.dart';
import 'package:xshop_mobile/models/shop.dart';
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
    return SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ShopDetails(shop: shops[index])),
          );
        },
        child: Container(
          padding: EdgeInsets.fromLTRB(5.0, 2.5, 5, 2.5),
          height: 200,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Container(
              padding: EdgeInsets.fromLTRB(5.0, 0, 5.0, 0.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(5.0, 0, 0.0, 0.0),
                        width: 120,
                        height: 140,
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage('images/try.jpg'),
                            fit: BoxFit.fill,
                          ),
                          border: Border.all(
                            color: Colors.teal[900],
                            width: 0,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 10.0, 0.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${shops[index].name}',
                              style: TextStyle(
                                  fontSize: 18.0,
                                  color: AppTheme.colors.primary,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'the shop is fantastic , ',
                              style: TextStyle(fontSize: 12),
                              softWrap: true,
                            ),
                            SizedBox(
                              height: 70,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.star,
                                  size: 20.0,
                                  color: Colors.orange,
                                ),
                                Icon(
                                  Icons.star,
                                  size: 20.0,
                                  color: Colors.orange,
                                ),
                                Icon(
                                  Icons.star,
                                  size: 20.0,
                                  color: Colors.orange,
                                ),
                                Icon(
                                  Icons.star,
                                  size: 20.0,
                                  color: Colors.orange,
                                ),
                                Icon(
                                  Icons.star,
                                  size: 20.0,
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  width: 20.0,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      IconButton(
                          icon: Icon(
                            Icons.favorite_border_rounded,
                            color: Colors.grey,
                            size: 25,
                          ),
                          onPressed: () {})
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }, childCount: shops.length));
  }
}
/*
 SizedBox(
                    height: 15.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.star,
                        size: 20.0,
                        color: Colors.orange,
                      ),
                      Icon(
                        Icons.star,
                        size: 20.0,
                        color: Colors.orange,
                      ),
                      Icon(
                        Icons.star,
                        size: 20.0,
                        color: Colors.orange,
                      ),
                      Icon(
                        Icons.star,
                        size: 20.0,
                        color: Colors.orange,
                      ),
                      Icon(
                        Icons.star,
                        size: 20.0,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                    ],
                  )
 */
/*
ListTile(
                    trailing: Icon(
                      Icons.shopping_cart_outlined,
                      size: 35,
                    ),
                    leading: Container(
                      width: 100,
                      decoration: BoxDecoration(
                        image: const DecorationImage(
                          image: AssetImage('images/try.jpg'),
                          fit: BoxFit.fill,
                        ),
                        border: Border.all(
                          color: Colors.teal[900],
                          width: 0,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    title: Text(
                      '${shops[index].name}',
                      style: TextStyle(
                          fontSize: 15.0,
                          color: AppTheme.colors.primary,
                          fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      'the shop is fantastic , you can buy in 24 hours a day. U will find '
                      'all U need',
                      style: TextStyle(fontSize: 10),
                    ),
                    isThreeLine: true,
                  ),
 */
/*
Container(
            height: 200,
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
 */
/*
Container(
                  width: MediaQuery.of(context).size.width * 0.94,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0.0),
                    ),
                    color: Colors.white70,
                    elevation: 10,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width * 0.28,
                              maxHeight: MediaQuery.of(context).size.width * 0.28,
                            ),
                            child: Image.asset(
                                'lib/images/burger_texas_angus.jpg',
                                fit: BoxFit.fill
                            ),
                          ),
                        ),
 */
