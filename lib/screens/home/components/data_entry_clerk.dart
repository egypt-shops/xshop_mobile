import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xshop_mobile/models/product.dart';
import 'package:xshop_mobile/screens/customer/products/product_search.dart';
import 'package:xshop_mobile/screens/customer/products/products.dart';
import 'package:xshop_mobile/screens/data_entry/new_order.dart';
import 'package:xshop_mobile/screens/data_entry/product_creating.dart';
import 'package:xshop_mobile/screens/home/components/profile.dart';
import 'package:xshop_mobile/screens/login/components/login_screen.dart';
import 'package:xshop_mobile/services/orders_api.dart';
import 'package:xshop_mobile/services/products.dart';
import 'package:xshop_mobile/services/shop_api.dart';
import 'package:http/http.dart' as http;

import '../../../services/invoices.dart';

class DataEntryClerk extends StatefulWidget {
  @override
  _DataEntryClerkState createState() => _DataEntryClerkState();
}

class _DataEntryClerkState extends State<DataEntryClerk> {
  SharedPreferences sharedPreferences;
  String name = 'Boyka';
  String mobile;
  String email;
  int _selectedIndex = 0;

  static List<Widget> _bottomDrawerOptions = <Widget>[
    ProductsDEC(),
    NewOrder(),
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
      //key: Key('DataEntry_Scaffold'),

      body: Builder(
          // Create an inner BuildContext so that the onPressed methods
          // can refer to the Scaffold with Scaffold.of().
          builder: (BuildContext context) {
        return _bottomDrawerOptions.elementAt(_selectedIndex);
      }),
      drawer: Drawer(
        //key: Key('DataEntry_Drawer'),
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
                'user account',
                style: TextStyle(color: Colors.black38),
              ),
              leading: Icon(Icons.account_circle),
              onTap: () {
                //Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (builder) {
                  return Profile(
                    name: name,
                    email: email,
                    phone: mobile,
                    type: 'Data Entry Clerk',
                  );
                }));
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
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: 'Products',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box),
            label: 'Add',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}

class ProductsDEC extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool _pinned = false;
    bool _snap = false;
    bool _floating = true;
    return CustomScrollView(slivers: <Widget>[
      SliverAppBar(
        pinned: _pinned,
        snap: _snap,
        floating: _floating,
        expandedHeight: 160.0,
        flexibleSpace: FlexibleSpaceBar(
          title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('DEC         ',
                    style: Theme.of(context).textTheme.bodyText1)
              ]),
          background: Icon(
            Icons.shopping_bag,
            size: 50,
            color: Theme.of(context).focusColor,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search,
                color: Theme.of(context).secondaryHeaderColor),
            tooltip: 'search for a product',
            onPressed: () {
              showSearch(context: context, delegate: ProductSearch(products));
            },
          )
          /*: PopupMenuButton(
                      child: Center(child: Text('click here')),
                      itemBuilder: (context) {
                        return List.generate(5, (index) {
                          return PopupMenuItem(
                            child: Text('button no $index'),
                          );
                        });
                      },
                    ),*/
        ],
        iconTheme: IconThemeData(color: Theme.of(context).accentColor),
        leading: IconButton(
          icon:
              Icon(Icons.person, color: Theme.of(context).secondaryHeaderColor),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      FutureBuilder<List<Product>>(
          future: fetchProducts(http.Client(), 'boyka'),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              products = snapshot.data;
              return SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: MediaQuery.of(context).size.width /
                        (MediaQuery.of(context).size.height / 1.6),
                  ),
                  delegate: SliverChildBuilderDelegate((context, index) {
                    return ProductListItem(index: index);
                  }, childCount: products.length));
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            } else {
              return SliverToBoxAdapter(
                  child: SizedBox(
                      height: 200,
                      width: 200,
                      child: Center(child: CircularProgressIndicator())));
            }
          })
    ]);
  }
}
