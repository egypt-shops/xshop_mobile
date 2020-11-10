import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xshop_mobile/screens/login/login.dart';

class Home extends StatelessWidget {
  final String name;

  const Home({Key key, this.name}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        home: HomeScreen());
  }
}
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  SharedPreferences sharedPreferences;
  String name='Boyka';
  String mobile='empty';
  String email='empty';

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString("token") == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => Login()),
          (Route<dynamic> route) => false);
    }
    else{
      setState(() {
        name=sharedPreferences.getString('name');
      mobile=sharedPreferences.getString('mobile');
      email=sharedPreferences.getString('email');
      });
      
    }
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
                          MaterialPageRoute(
                              builder: (BuildContext context) => Login()),
                          (Route<dynamic> route) => false);
                    },
                    child:
                        Text("Log Out", style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
              body: Container(
                child: Center(child: Text("login successfully")),
                color: Colors.blue[50],
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
                    Icon(Icons.account_circle, size: 60,color: Colors.white,),
                    Text('Mohamed Boyka'),
                    
                  ]),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Mobile: '+this.mobile),
              onTap: () {

                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Email: '+this.email),
              onTap: () {
     
                Navigator.pop(context);
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
