import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xshop_mobile/screens/login/login.dart';
import 'package:xshop_mobile/screens/data_entry/main_of_data_entry.dart';

class DataEntryClerk extends StatefulWidget {
  @override
  _DataEntryClerkState createState() => _DataEntryClerkState();
}

class _DataEntryClerkState extends State<DataEntryClerk> {
  SharedPreferences sharedPreferences;
  String name = 'Boyka';
  String mobile = 'empty';
  String email = 'empty';

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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: new ThemeData(
          primarySwatch: Colors.yellow,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text("xshop", style: TextStyle(color: Colors.black)),
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
                child: Text("Log Out", style: TextStyle(color: Colors.black)),
              ),
            ],
          ),
          body: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                Text('Data Entery',
                    style: TextStyle(fontSize: 30, color: Colors.yellow[600])),
                RaisedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (c) => DataEntry()));
                    },
                    textColor: Colors.black,
                    padding: const EdgeInsets.all(0.0),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: <Color>[
                            Colors.yellow,
                            Colors.yellow[200],
                            Colors.yellow[100],
                          ],
                        ),
                      ),
                      padding: const EdgeInsets.all(10.0),
                      child: const Text('Data Entery',
                          style: TextStyle(fontSize: 20)),
                    ))
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
                          color: Colors.black,
                        ),
                        Text('Mohamed Boyka'),
                      ]),
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                  ),
                ),
                ListTile(
                    title: Text('Mobile: ' + mobile),
                    trailing: Icon(Icons.create),
                    onTap: () {
                      createAlertDialog(context, 'mobile');
                    }),
                ListTile(
                  title: Text('Email: ' + email),
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
