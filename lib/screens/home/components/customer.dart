import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xshop_mobile/models/favorites.dart';
import 'package:xshop_mobile/models/invoice.dart';
import 'package:xshop_mobile/models/order.dart';
import 'package:xshop_mobile/models/shop.dart';
import 'package:xshop_mobile/screens/customer/favorites/components/fav_products.dart';
import 'package:xshop_mobile/screens/customer/favorites/components/fav_shops.dart';
import 'package:xshop_mobile/screens/customer/favorites/favorites.dart';
import 'package:xshop_mobile/screens/customer/invoices/search.dart';
import 'package:xshop_mobile/screens/customer/orders/create_order.dart';
import 'package:xshop_mobile/screens/customer/shops/shop_search.dart';
import 'package:xshop_mobile/screens/customer/shops/shops.dart';
import 'package:xshop_mobile/screens/home/components/about.dart';
import 'package:xshop_mobile/screens/login/components/login_screen.dart';
import 'package:xshop_mobile/screens/home/components/profile.dart';

import 'package:xshop_mobile/theme/apptheme.dart';
import 'package:xshop_mobile/screens/login/login.dart';
import 'package:xshop_mobile/screens/customer/products/products.dart';
import 'package:xshop_mobile/screens/customer/orders/order_search.dart';
import 'package:xshop_mobile/services/orders_api.dart';
import 'package:xshop_mobile/services/shop_api.dart';
import 'package:wifi/wifi.dart';
import 'package:ping_discover_network/ping_discover_network.dart';
import '../../../services/invoices.dart';

List<Shop> shops = [];
List<Order> orders = [];
List<Invoice> invoices = [];

class Customer extends StatefulWidget {
  @override
  _CustomerState createState() => _CustomerState();
}

class _CustomerState extends State<Customer> {
  SharedPreferences sharedPreferences;
  String name = 'Boyka';
  String mobile;
  String email;
  int _selectedIndex = 0;
  bool _pinned = false;
  bool _snap = false;
  bool _floating = true;

  static List<Widget> _bottomDrawerOptions = <Widget>[
    ShopApi(),
    OrderApi(),
    InvoiceApi()
  ];
  static List<SearchDelegate> _searchOptions = <SearchDelegate>[
    ShopsSearch(),
    OrdersSearch(),
    InvoicesSearch()
  ];
  @override
  void initState() {
    super.initState();
    getLoginStatus();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  getLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    //await discoverWifiPrinter();
    setState(() {
      name = sharedPreferences.getString('name');
      mobile = sharedPreferences.getString('mobile');
      email = sharedPreferences.getString('email');
    });
  }

  logout() {
    sharedPreferences.clear();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (BuildContext context) => LoginScreen()),
    );
  }

  createAlertDialog(BuildContext context, String userInfo) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('change $userInfo'),
            content: TextFormField(
                decoration: InputDecoration(
              hintText: 'new ' + userInfo,
            )),
            actions: <Widget>[
              FlatButton(
                  child: new Text("Save"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  })
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Builder(
          // Create an inner BuildContext so that the onPressed methods
          // can refer to the Scaffold with Scaffold.of().
          builder: (BuildContext context) {
        return CustomScrollView(slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Colors.transparent,
            elevation: 0, // 1
            pinned: _pinned,
            snap: _snap,
            floating: _floating,
            expandedHeight: 160.0,

            flexibleSpace: FlexibleSpaceBar(
                title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('welcome to Xshop        ',
                          style: Theme.of(context).textTheme.bodyText1)
                    ]),
                background: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      colorFilter: new ColorFilter.mode(
                          Colors.black.withOpacity(0.3), BlendMode.darken),
                      image: AssetImage("images/Cashier-Area.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                )),

            actions: <Widget>[
              IconButton(
                key: Key("search for shop"),
                icon: Icon(Icons.search, color: Theme.of(context).primaryColor),
                tooltip: "search for shop",
                onPressed: () {
                  showSearch(
                      context: context,
                      delegate: _searchOptions.elementAt(_selectedIndex));
                },
              ),
            ],
            iconTheme: IconThemeData(color: Theme.of(context).accentColor),
            leading: IconButton(
              icon: Icon(Icons.person, color: Theme.of(context).primaryColor),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
          _bottomDrawerOptions.elementAt(_selectedIndex),
        ]);
      }),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/meeting.jpg'), fit: BoxFit.fill),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage('images/an.jpg'),
                    radius: 35,
                  ),
                  Text(
                    'Mohamed Boyka',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              title: Text(
                'home',
                style: TextStyle(color: Colors.black38),
              ),
              leading: Icon(Icons.home),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text(
                'favorites',
                style: TextStyle(color: Colors.black38),
              ),
              leading: Icon(Icons.favorite),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => FavoritesPage()));
              },
            ),
            ListTile(
              title: Text(
                'user account',
                style: TextStyle(color: Colors.black38),
              ),
              leading: Icon(Icons.account_circle),
              onTap: () {
                //Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (builder) => Profile(
                              name: name,
                              email: email,
                              phone: mobile,
                              type: 'Customer',
                            )));
              },
            ),
            Divider(),
            ListTile(
              title: Text(
                'about',
                style: TextStyle(color: Colors.black38),
              ),
              leading: Icon(Icons.info),
              onTap: () {
                openAbout(context);
              },
            ),
            ListTile(
              title: Text(
                'Log Out',
                style: TextStyle(color: Colors.black38),
              ),
              leading: Icon(Icons.logout),
              onTap: () {
                logout();
                //Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt),
            label: 'Invoices',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
