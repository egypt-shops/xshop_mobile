import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xshop_mobile/screens/home/home.dart';
import 'package:xshop_mobile/services/signin_test.dart';

final TextEditingController mobileController = new TextEditingController();
final TextEditingController passwordController = new TextEditingController();

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final signin = SignIn();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Container(
                padding: EdgeInsets.all(80.0),
                color: Colors.blue[50],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'xshop',
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextFormField(
                              decoration: InputDecoration(
                                hintText: 'Mobile',
                              ),
                              controller: mobileController),
                          TextFormField(
                              decoration: InputDecoration(
                                hintText: 'Password',
                              ),
                              obscureText: true,
                              controller: passwordController),
                          SizedBox(
                            height: 24,
                          ),
                          RaisedButton(
                              color: Colors.blue[500],
                              child: Text('LOGIN'),
                              onPressed: //(mobileController.text == "" || passwordController.text == "") ? (){print('error ${mobileController.text}'); }:
                                  () async {
                                User user_data = await signin.signIn(
                                    mobileController.text,
                                    passwordController.text);
                                if (user_data != null) {
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              Home(name: 'boyka')),
                                      (Route<dynamic> route) => false);
                                }

                                //Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => LoginAPI(mobile: mobileController.text,password: passwordController.text,)), (Route<dynamic> route) => false);
                              })
                        ])
                  ],
                ))));
  }
}
