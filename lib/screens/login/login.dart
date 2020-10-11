import 'package:flutter/material.dart';
import './components/login_screen.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: LoginScreen(),
    ));
  }
}
