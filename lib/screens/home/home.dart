import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xshop_mobile/screens/login/login.dart';

class Home extends StatelessWidget {
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
              drawer: Drawer(),
            );
  }
}
