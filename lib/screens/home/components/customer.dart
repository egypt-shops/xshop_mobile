import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xshop_mobile/models/invoice.dart';
import 'package:xshop_mobile/models/order.dart';
import 'package:xshop_mobile/models/shop.dart';
import 'package:xshop_mobile/screens/customer/invoices/search.dart';
import 'package:xshop_mobile/screens/customer/orders/create_order.dart';
import 'package:xshop_mobile/screens/customer/shops/shop_search.dart';
import 'package:xshop_mobile/screens/customer/shops/shops.dart';
import 'package:xshop_mobile/screens/login/components/login_screen.dart';
import 'package:xshop_mobile/theme/apptheme.dart';
import 'package:xshop_mobile/screens/login/login.dart';
import 'package:xshop_mobile/screens/customer/products/products.dart';
import 'package:xshop_mobile/screens/customer/orders/order_search.dart';
import 'package:xshop_mobile/services/orders_api.dart';
import 'package:xshop_mobile/services/shop_api.dart';

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

    setState(() {
      name = sharedPreferences.getString('name');
      mobile = sharedPreferences.getString('mobile');
      email = sharedPreferences.getString('email');
    });
  }

  logout() {
    sharedPreferences.clear();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (BuildContext context) => LoginScreen()),
        (Route<dynamic> route) => false);
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
      body: Builder(
          // Create an inner BuildContext so that the onPressed methods
          // can refer to the Scaffold with Scaffold.of().
          builder: (BuildContext context) {
        return CustomScrollView(slivers: <Widget>[
          SliverAppBar(
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
              background: Icon(
                Icons.shopping_cart,
                size: 50,
                color: Theme.of(context).focusColor,
              ),
            ),
            actions: <Widget>[
              IconButton(
                key: Key("search for shop"),
                icon: Icon(Icons.search,
                    color: Theme.of(context).secondaryHeaderColor),
                tooltip: 'search for shop',
                onPressed: () {
                  showSearch(
                      context: context,
                      delegate: _searchOptions.elementAt(_selectedIndex));
                },
              ),
            ],
            iconTheme: IconThemeData(color: Theme.of(context).accentColor),
            leading: IconButton(
              icon: Icon(Icons.person,
                  color: Theme.of(context).secondaryHeaderColor),
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
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  Text(
                    '$email',
                    style: TextStyle(color: Colors.white),
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
                //Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text(
                'account user',
                style: TextStyle(color: Colors.black38),
              ),
              leading: Icon(Icons.account_circle),
              onTap: () {
                //Navigator.pop(context);
              },
            ),
            ListTile(
                title: Text(
                  '$mobile',
                  style: TextStyle(color: Colors.black38),
                ),
                leading: Icon(Icons.phone_iphone_outlined),
                onTap: () {
                  createAlertDialog(context, 'mobile');
                }),
            ListTile(
              title: Text(
                '$email',
                style: TextStyle(color: Colors.black38),
              ),
              leading: Icon(Icons.email),
              onTap: () {
                createAlertDialog(context, 'email');
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
                //Navigator.pop(context);
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

        /*Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      Icons.account_circle,
                      size: 60,
                      color: Colors.white,
                    ),
                    Text(
                      'Mohamed Boyka',
                      style: TextStyle(color: Colors.white),
                    ),
                  ]),

            ListTile(
                title: Text('Mobile: $mobile'),
                trailing: Icon(Icons.create),
                onTap: () {
                  createAlertDialog(context, 'mobile');
                }),
            ListTile(
              title: Text('Email: $email'),
              trailing: Icon(Icons.create),
              onTap: () {
                createAlertDialog(context, 'email');
              },
            ),
            ListTile(
              title: Text('Item 3'),
              onTap: () {
                //Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text(
                'Logout',
                style: Theme.of(context).textTheme.bodyText2,
              ),
              onTap: () {
                logout();
                //Navigator.pop(context);
              },
            ),
          ],
        ),
      )),
      */
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
