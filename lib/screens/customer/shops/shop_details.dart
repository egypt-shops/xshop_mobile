import 'package:backdrop/backdrop.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:xshop_mobile/models/shop.dart';
import 'package:xshop_mobile/screens/customer/products/cart.dart';
import 'package:xshop_mobile/screens/customer/products/checkout.dart';
import 'package:xshop_mobile/screens/customer/products/payment.dart';
import 'package:xshop_mobile/screens/customer/products/products.dart';
import 'package:xshop_mobile/screens/customer/products/product_search.dart';
import 'package:xshop_mobile/services/products.dart';
import 'package:xshop_mobile/services/search_shop.dart';
import 'package:xshop_mobile/theme/apptheme.dart';
import 'package:http/http.dart' as http;

class ShopDetails extends StatefulWidget {
  ShopDetails(this.id, this.shopname, this.subdomain);
  final int id;
  final String shopname;
  final String subdomain;
  @override
  _ShopDetailsState createState() => _ShopDetailsState();
}

class _ShopDetailsState extends State<ShopDetails> {
  // make object from scanner

  @override
  Widget build(BuildContext context) {
    return BackdropScaffold(
        appBar: BackdropAppBar(
            title: Text(
              "${widget.shopname}",
              style: Theme.of(context).textTheme.bodyText1,
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            actions: <Widget>[
              Builder(
                  builder: (context) => (Container(
                      child: Backdrop.of(context).isBackLayerConcealed
                          ? null
                          : IconButton(
                              icon: Icon(
                                Icons.search,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                showSearch(
                                    context: context,
                                    delegate: ProductSearch(products));
                              })))),
              BackdropToggleButton(icon: AnimatedIcons.view_list),
              IconButton(
                  icon: Icon(
                    Icons.payment,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Checkout(
                          shopName: widget.shopname,
                        ),
                      ),
                    );
                  }),
            ]),
        stickyFrontLayer: false,
        frontLayer: DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: TabBar(
                indicatorColor: Theme.of(context).primaryColor,
                tabs: [
                  Tab(icon: Icon(Icons.store)),
                  Tab(icon: Icon(Icons.shopping_cart)),
                ],
              ),
              body: TabBarView(
                children: [
                  GetShop(widget.subdomain),
                  CartPage(),
                ],
              ),
            )),
        backLayer: Products(
          shopName: widget.subdomain,
        ));
  }
}

class GetShop extends StatelessWidget {
  GetShop(this.subdomain);
  final String subdomain;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<Shop>(
            future: fetchShopByID(http.Client(), subdomain),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ShopHome(shop: snapshot.data);
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

class ShopHome extends StatelessWidget {
  final Shop shop;
  ShopHome({key, this.shop}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 5,
          child: Container(
            height: 200,
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage('images/store.jpg'),
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
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 30, 20.0, 0),
            child: Opacity(
              opacity: 0.5,
              child: Text(
                shop.name +
                    '  '
                        ' is shop that provides a lot of products '
                        'this is shop that provides a lot of products '
                        'this is shop that provides a lot of products '
                        'this is shop that provides a lot of products '
                        'this is shop that provides a lot of products '
                        'this is shop that provides a lot of products '
                        'this is shop that provides a lot of products ',
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 13.0, color: Colors.black),
              ),
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
                    Backdrop.of(context).fling();
                  },
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.orange)),
                  child: Text(
                    'Products',
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
    );
  }
}
