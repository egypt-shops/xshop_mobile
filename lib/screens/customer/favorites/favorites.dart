import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xshop_mobile/models/favorites.dart';
import 'package:xshop_mobile/models/shop.dart';
import 'package:xshop_mobile/screens/customer/favorites/components/fav_products.dart';
import 'package:xshop_mobile/screens/customer/favorites/components/fav_shops.dart';
import 'package:xshop_mobile/screens/customer/shops/shop_details.dart';

class FavoritesPage extends StatelessWidget {
  static String routeName = '/favorites_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Favorites'),
            backgroundColor: Colors.transparent,
            elevation: 0, // 1

            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios,
                  color: Theme.of(context).primaryColor),
              onPressed: () {
                Navigator.pop(context);
              },
            )),
        body: DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: TabBar(
                indicatorColor: Theme.of(context).primaryColor,
                tabs: [
                  Tab(icon: Icon(Icons.store)),
                  Tab(icon: Icon(Icons.shopping_bag)),
                ],
              ),
              body: TabBarView(
                children: [
                  FavoritesShopsPage(),
                  FavoritesProductsPage(),
                ],
              ),
            )));
  }
}
