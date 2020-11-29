import 'package:flutter/material.dart';
import 'package:xshop_mobile/screens/home/home.dart';
import 'screens/login/login.dart';
import 'screens/home/components/sub_manager.dart';

void main() {
  runApp(Xshop());
}

class Xshop extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'xshop',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        '/': (context) => Home(),
        '/login': (context) => Login(),
      },
    );
  }
}
