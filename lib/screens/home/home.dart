import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xshop_mobile/screens/home/components/cashier.dart';
import 'package:xshop_mobile/screens/home/components/customer.dart';
import 'package:xshop_mobile/screens/home/components/General_manager.dart';
import 'package:xshop_mobile/screens/home/components/data_entry_clerk.dart';
import 'package:xshop_mobile/screens/login/login.dart';
import 'package:xshop_mobile/components/circular_indicator.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  SharedPreferences sharedPreferences;
  String type = 'empty';
  String mobile = 'empty';
  String email = 'empty';

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
    } else {
      setState(() {
        type = sharedPreferences.getString('type');
        mobile = sharedPreferences.getString('mobile');
        email = sharedPreferences.getString('email');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case 'Customer':
        return MaterialApp(home: Customer());
        break;
      case 'Cashier':
        return MaterialApp(home: Cashier());
        break;
      case 'General Manager':
        return MaterialApp(home: GeneralManager());
        break;
      case 'Data Entry Clerk':
        return MaterialApp(home: DataEntryClerk());
        break;
      default:
        return MaterialApp(home: Customer());
    }
  }
}
