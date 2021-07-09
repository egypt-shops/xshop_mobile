import 'package:flutter/material.dart';

import 'package:xshop_mobile/screens/home/components/cashier.dart';
import 'package:xshop_mobile/screens/home/components/customer.dart';
import 'package:xshop_mobile/screens/home/components/data_entry_clerk.dart';
import 'package:xshop_mobile/screens/login/components/login_screen.dart';
import 'package:xshop_mobile/main.dart';

String usertype = 'empty';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String mobile = 'empty';
  String email = 'empty';

  @override
  void initState() {
    super.initState();
    setState(() {
      usertype = sharedPreferences.getString('type');
      mobile = sharedPreferences.getString('mobile');
      email = sharedPreferences.getString('email');
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (usertype) {
      case 'Customer':
        return Customer();
        break;
      case 'Cashier':
        return Cashier();
        break;
      case 'Data Entry Clerk':
        return DataEntryClerk();
        break;
      default:
        return Customer();
    }
  }
}
