import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xshop_mobile/screens/home/components/cashier.dart';
import 'package:xshop_mobile/screens/home/components/customer.dart';
import 'package:xshop_mobile/screens/home/components/sub_manager.dart';
import 'package:xshop_mobile/screens/home/components/data_entry_clerk.dart';
import 'package:xshop_mobile/screens/login/login.dart';

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
      case 'CUSTOMER':
        return MaterialApp(home: Customer());
        break;
      case 'CASHIER':
        return MaterialApp(home: Cashier());
        break;
      case 'SUB_MANAGER':
        return MaterialApp(home: SubManager());
        break;
      case 'DATA_ENTRY_CLERK':
        return MaterialApp(home: DataEntryClerk());
        break;
      default:
        return MaterialApp(home: Customer());
    }
  }
}
