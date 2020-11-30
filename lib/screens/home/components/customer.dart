import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xshop_mobile/screens/login/login.dart';
import 'package:xshop_mobile/screens/data_entry/main_of_data_entry.dart';

class Customer extends StatefulWidget {
  @override
  _CustomerState createState() => _CustomerState();
}

class _CustomerState extends State<Customer> {
  SharedPreferences sharedPreferences;
  String name = 'Boyka';
  String mobile;
  String email;

  @override
  void initState() {
    super.initState();
    getLoginStatus();
  }

  getLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();

    setState(() {
      name = sharedPreferences.getString('name');
      mobile = sharedPreferences.getString('mobile');
      email = sharedPreferences.getString('email');
    });
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
    return MaterialApp(
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
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
                      MaterialPageRoute(
                          builder: (BuildContext context) => Login()),
                      (Route<dynamic> route) => false);
                },
                child: Text("Log Out", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
          body: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                Text('Customer',
                    style: TextStyle(fontSize: 30, color: Colors.blue)),
              ])),
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
                        Text('Mohamed Boyka'),
                      ]),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                ),
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
                  title: Text('Item 4'),
                  onTap: () {
                    //Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
