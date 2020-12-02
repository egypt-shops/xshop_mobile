import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xshop_mobile/screens/home/components/General_manager.dart';
import 'package:xshop_mobile/screens/home/components/customer.dart';
import 'package:xshop_mobile/screens/home/components/cashier.dart';
import 'package:xshop_mobile/screens/home/home.dart';
import 'package:xshop_mobile/services/signin.dart';
import 'package:progress_dialog/progress_dialog.dart';

final TextEditingController mobileController = new TextEditingController();
final TextEditingController passwordController = new TextEditingController();

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final signin = SignIn();
  ProgressDialog pr;
  createAlertDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text('incorrect mobile or password',
                style: TextStyle(color: Colors.red)),
            actions: <Widget>[
              FlatButton(
                  child: new Text("Close"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  })
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context);
    pr.style(
        message: '  logging in..',
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: CircularProgressIndicator(),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        maxProgress: 100.0,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600));
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
                                pr.show();
                                User user_data = await signin.signIn(
                                    mobileController.text,
                                    passwordController.text);
                                if (user_data != null) {
                                  pr.hide().whenComplete(() {
                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                Home()),
                                        (Route<dynamic> route) => false);
                                  });
                                } else {
                                  pr.hide().whenComplete(() {
                                    createAlertDialog(context);
                                  });
                                }

                                //Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => LoginAPI(mobile: mobileController.text,password: passwordController.text,)), (Route<dynamic> route) => false);
                              })
                        ])
                  ],
                ))));
  }
}
