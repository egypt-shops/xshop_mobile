import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xshop_mobile/screens/login/login.dart';
import 'package:xshop_mobile/screens/data_entry/main_of_data_entry.dart';
import '../search_product/search_products.dart';

class Home extends StatelessWidget {
  final String name;

  const Home({Key key, this.name}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomeScreen());
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  SharedPreferences sharedPreferences;
  String name = 'Boyka';
  String mobile = 'empty';
  String email = 'empty';

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  createAlertDialog(BuildContext context, String user_info) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('change $user_info'),
            content: TextFormField(
                decoration: InputDecoration(
              hintText: 'new ' + user_info,
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

  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    // if (sharedPreferences.getString("token") == null) {
    //   Navigator.of(context).pushAndRemoveUntil(
    //       MaterialPageRoute(builder: (BuildContext context) => Login()),
    //       (Route<dynamic> route) => false);
    // } else {
    setState(() {
      name = 'Mohamed'; // sharedPreferences.getString('name');
      mobile = '01002266555'; // sharedPreferences.getString('mobile');
      email = 'mohamed@gmail.com'; //sharedPreferences.getString('email');
    });
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("xshop", style: TextStyle(color: Colors.white)),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              if (sharedPreferences != null) {
                sharedPreferences.clear();
                sharedPreferences.commit();
              }
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (BuildContext context) => Login()),
                  (Route<dynamic> route) => false);
            },
            child: Text("Log Out", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: Container(
        color: Colors.white30,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (c) => DataEntry()),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white30,
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    margin: EdgeInsets.only(right: 20),
                    child: Text(
                      'Data Entry',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
              ),
              color: Colors.blue[50],
            ),
            Container(
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (c) => SearchProduct()),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white30,
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    margin: EdgeInsets.only(right: 20),
                    child: Text(
                      'Search Product',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue),
                    ),
                  ),
                ),
              ),
              color: Colors.blue[50],
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      Icons.account_circle,
                      size: 60,
                      color: Colors.white,
                    ),
                    Text('Ramy Safaa'),
                  ]),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
                title: Text('Mobile: ' + this.mobile),
                trailing: Icon(Icons.create),
                onTap: () {
                  createAlertDialog(context, 'mobile');
                }),
            ListTile(
              title: Text('Email: ' + this.email),
              trailing: Icon(Icons.create),
              onTap: () {
                createAlertDialog(context, 'email');
              },
            ),
            ListTile(
              title: Text('Item 3'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Item 4'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
