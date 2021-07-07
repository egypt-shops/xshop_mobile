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
  bool isChecked = false;

  final signin = SignIn();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Container(
                padding: EdgeInsets.all(30.0),
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
                                child: Form(
                                    key: _formKey,
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          TextFormField(
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Enter mobile number';
                                                }

                                                return null;
                                              },
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
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Enter your password';
                                                }

                                                return null;
                                              },
                                              decoration: InputDecoration(
                                                suffixIcon: IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        isChecked = !isChecked;
                                                      });
                                                    },
                                                    icon: Icon(isChecked
                                                        ? Icons.visibility
                                                        : Icons
                                                            .visibility_off)),
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
                                              obscureText:
                                                  isChecked ? false : true,
                                              controller: passwordController),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "Forget password?",
                                                style: TextStyle(fontSize: 12),
                                              ),
                                              TextButton(
                                                  onPressed: () {},
                                                  child: Text('Reset',
                                                      style: TextStyle(
                                                          fontSize: 12)))
                                            ],
                                          ),
                                          SizedBox(
                                            height: 30,
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
                                                if (_formKey.currentState
                                                    .validate()) {
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
                                                                builder:
                                                                    (BuildContext
                                                                            context) =>
                                                                        Home()),
                                                            (Route<dynamic>
                                                                    route) =>
                                                                false);
                                                  } else {
                                                    setState(() {
                                                      isloading = false;
                                                    });
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(SnackBar(
                                                      backgroundColor:
                                                          Colors.red,
                                                      content: Text(
                                                        'Incorrect mobile or password!',
                                                      ),
                                                    ));
                                                  }
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
                            child: SizedBox(
                                width: 100,
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        'Register',
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .secondaryHeaderColor),
                                      ),
                                      Icon(Icons.arrow_forward_ios,
                                          color: Theme.of(context)
                                              .secondaryHeaderColor)
                                    ])),
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
