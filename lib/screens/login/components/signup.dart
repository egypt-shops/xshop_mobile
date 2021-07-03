import 'package:flutter/material.dart';
import 'package:xshop_mobile/services/signin.dart';
import 'package:xshop_mobile/theme/apptheme.dart';

final TextEditingController mobileController = new TextEditingController();
final TextEditingController passwordController = new TextEditingController();

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isloading = false;
  bool issignup = false;
  final signin = SignIn();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Container(
                padding: EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(bottom: 20, top: 20),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('welcome to ',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Theme.of(context).primaryColor)),
                              Text('xshop',
                                  style: TextStyle(
                                      fontSize: 70,
                                      color: Theme.of(context).primaryColor)),
                            ])),
                    isloading
                        ? SizedBox(
                            height: 300,
                            width: 300,
                            child: Center(
                                child: CircularProgressIndicator(
                              valueColor: new AlwaysStoppedAnimation<Color>(
                                  AppTheme.colors.primary),
                              backgroundColor: Theme.of(context).primaryColor,
                            )))
                        : Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18)),
                            color: Theme.of(context).secondaryHeaderColor,
                            child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: SizedBox(
                                    height: 470,
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10),
                                              child: Text(
                                                'Name',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: AppTheme
                                                        .colors.primaryDark),
                                              )),
                                          TextField(
                                              decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                            ),
                                            hintText: "your name",
                                          )),
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10),
                                              child: Text(
                                                'Mobile',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: AppTheme
                                                        .colors.primaryDark),
                                              )),
                                          TextField(
                                              decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                            ),
                                            hintText: "+20xxxxxxxxxx",
                                          )),
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10),
                                              child: Text(
                                                'Email',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: AppTheme
                                                        .colors.primaryDark),
                                              )),
                                          TextField(
                                              decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                            ),
                                            hintText: "yourmail@example.com",
                                          )),
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10),
                                              child: Text(
                                                'Password',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: AppTheme
                                                        .colors.primaryDark),
                                              )),
                                          TextField(
                                              obscureText: true,
                                              decoration: InputDecoration(
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: AppTheme
                                                        .colors.secondry,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                focusedBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: AppTheme
                                                          .colors.secondry),
                                                ),
                                              )),
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10),
                                              child: Text(
                                                'Confirm Password',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: AppTheme
                                                        .colors.primaryDark),
                                              )),
                                          TextField(
                                              obscureText: true,
                                              decoration: InputDecoration(
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: AppTheme
                                                        .colors.secondry,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                focusedBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: AppTheme
                                                          .colors.secondry),
                                                ),
                                              )),
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 30),
                                              child: RaisedButton(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              18.0)),
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  child: Text(
                                                    'SIGN ME UP',
                                                    style: TextStyle(
                                                        color: Theme.of(context)
                                                            .secondaryHeaderColor),
                                                  ),
                                                  onPressed: //(mobileController.text == "" || passwordController.text == "") ? (){print('error ${mobileController.text}'); }:
                                                      () {
                                                    showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return AlertDialog(
                                                            elevation: 10,
                                                            backgroundColor:
                                                                AppTheme.colors
                                                                    .primary,
                                                            title: Text('Oops',
                                                                style: TextStyle(
                                                                    color: AppTheme
                                                                        .colors
                                                                        .textPrimary)),
                                                            content: Container(
                                                                decoration: BoxDecoration(
                                                                    color: AppTheme
                                                                        .colors
                                                                        .primaryLight,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            5)),
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            15),
                                                                child: SizedBox(
                                                                    height: 200,
                                                                    child: Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceEvenly,
                                                                        children: [
                                                                          Text(
                                                                            "you're not allowed to register! ",
                                                                          ),
                                                                          Image.asset(
                                                                              'images/signup.jpeg')
                                                                        ]))),
                                                            actions: <Widget>[
                                                              FlatButton(
                                                                  child:
                                                                      new Text(
                                                                    "ماشي",
                                                                    style: TextStyle(
                                                                        color: AppTheme
                                                                            .colors
                                                                            .secondry,
                                                                        fontSize:
                                                                            15),
                                                                  ),
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  })
                                                            ],
                                                          );
                                                        });
                                                  }))
                                        ])))),
                    Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0)),
                            color: Theme.of(context).primaryColor,
                            child: SizedBox(
                                width: 100,
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(
                                        Icons.arrow_left,
                                        color: Theme.of(context)
                                            .secondaryHeaderColor,
                                      ),
                                      Text(
                                        'LOGIN',
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .secondaryHeaderColor),
                                      )
                                    ])),
                            onPressed: () {
                              Navigator.pop(context);
                            }))
                  ],
                )))));
  }
}
