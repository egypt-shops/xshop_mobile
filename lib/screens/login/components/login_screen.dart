import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xshop_mobile/screens/home/components/General_manager.dart';
import 'package:xshop_mobile/screens/home/components/customer.dart';
import 'package:xshop_mobile/screens/login/components/signup.dart';
import 'package:xshop_mobile/screens/home/home.dart';
import 'package:xshop_mobile/services/signin.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:xshop_mobile/theme/apptheme.dart';

final TextEditingController mobileController = new TextEditingController();
final TextEditingController passwordController = new TextEditingController();

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isloading = false;
  bool issignup = false;
  final signin = SignIn();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Container(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('xshop',
                        style: TextStyle(
                            fontSize: 70,
                            color: Theme.of(context).primaryColor)),
                    isloading
                        ? SizedBox(
                            key: Key("Sign In indicator"),
                            height: 300,
                            width: 300,
                            child: Center(child: CircularProgressIndicator()))
                        : Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18)),
                            color: Theme.of(context).secondaryHeaderColor,
                            child: Padding(
                                padding: const EdgeInsets.all(40),
                                child: SizedBox(
                                    height: 230,
                                    width: 230,
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          TextFormField(
                                              decoration: InputDecoration(
                                                  enabledBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Theme.of(context)
                                                            .backgroundColor),
                                                  ),
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Theme.of(context)
                                                            .primaryColor),
                                                  ),
                                                  hintText: 'Mobile'),
                                              controller: mobileController),
                                          TextFormField(
                                              decoration: InputDecoration(
                                                enabledBorder:
                                                    UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .backgroundColor,
                                                )),
                                                focusedBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .primaryColor),
                                                ),
                                                hintText: 'Password',
                                              ),
                                              obscureText: true,
                                              controller: passwordController),
                                          SizedBox(
                                            height: 50,
                                          ),
                                          RaisedButton(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          18.0)),
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              child: Text('LOGIN',
                                                  style: TextStyle(
                                                    color: Theme.of(context)
                                                        .secondaryHeaderColor,
                                                  )),
                                              onPressed: //(mobileController.text == "" || passwordController.text == "") ? (){print('error ${mobileController.text}'); }:
                                                  () async {
                                                setState(() {
                                                  isloading = true;
                                                });
                                                User user_data =
                                                    await signin.signIn(
                                                        mobileController.text,
                                                        passwordController
                                                            .text);
                                                if (user_data != null) {
                                                  Navigator.of(context)
                                                      .pushAndRemoveUntil(
                                                          MaterialPageRoute(
                                                              builder: (BuildContext
                                                                      context) =>
                                                                  Home()),
                                                          (Route<dynamic>
                                                                  route) =>
                                                              false);
                                                } else {
                                                  setState(() {
                                                    isloading = false;
                                                  });
                                                  /*Scaffold.of(context)
                                                          .showSnackBar(
                                                              SnackBar(
                                                        content: Text(
                                                            'Incorrect mobile or password!'),*
                                                      ));*/
                                                }

                                                //Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => LoginAPI(mobile: mobileController.text,password: passwordController.text,)), (Route<dynamic> route) => false);
                                              })
                                        ])))),
                    Visibility(
                        visible: isloading ? false : true,
                        child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0)),
                            color: Theme.of(context).primaryColor,
                            child: Text(
                              'SIGNUP',
                              style: TextStyle(
                                  color:
                                      Theme.of(context).secondaryHeaderColor),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUpScreen()),
                              );
                            }))
                  ],
                ))));
  }
}
