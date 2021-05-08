import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xshop_mobile/screens/login/login.dart';
import 'package:xshop_mobile/screens/data_entry/main_of_data_entry.dart';

class GeneralManager extends StatefulWidget {
  @override
  _GeneralManagerState createState() => _GeneralManagerState();
}

class _GeneralManagerState extends State<GeneralManager> {
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
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
            Text('General Manager',
                style: TextStyle(fontSize: 30, color: Colors.red)),
          ])),
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
                    email,
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            ListTile(
              title: Text('home'),
              leading: Icon(Icons.home),
              onTap: () {
                //Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('account user'),
              leading: Icon(Icons.account_circle),
              onTap: () {
                //Navigator.pop(context);
              },
            ),
            ListTile(
                title: Text(mobile),
                leading: Icon(Icons.phone_iphone_outlined),
                onTap: () {
                  createAlertDialog(context, 'mobile');
                }),
            ListTile(
              title: Text(email),
              leading: Icon(Icons.email),
              onTap: () {
                createAlertDialog(context, 'email');
              },
            ),
            Divider(),
            ListTile(
              title: Text('about'),
              leading: Icon(Icons.info),
              onTap: () {
                //Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Log Out'),
              leading: Icon(Icons.logout),
              onTap: () {
                //Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
/*
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
 */
