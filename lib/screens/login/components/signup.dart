import 'package:flutter/material.dart';
import 'package:xshop_mobile/services/register.dart';
import 'package:xshop_mobile/services/signin.dart';
import 'package:xshop_mobile/theme/apptheme.dart';
import 'package:http/http.dart' as http;

final TextEditingController nameController = new TextEditingController();
final TextEditingController mailController = new TextEditingController();
final TextEditingController mobileController = new TextEditingController();
final TextEditingController passwordController = new TextEditingController();
final TextEditingController password2Controller = new TextEditingController();

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool issignup = false;
  bool isChecked = false;

  final signin = SignIn();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0, // 1

            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios,
                  color: Theme.of(context).primaryColor),
              onPressed: () {
                Navigator.pop(context);
              },
            )),
        body: SingleChildScrollView(
            child: Center(
                child: Container(
                    padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
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
                            ]),
                        SizedBox(
                          height: 20,
                        ),
                        issignup
                            ? FutureBuilder<int>(
                                future: register(
                                    http.Client(),
                                    nameController.text,
                                    mobileController.text,
                                    passwordController.text,
                                    password2Controller.text),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return SizedBox(
                                        height: 600,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              snapshot.data == 200
                                                  ? "successfully registered!"
                                                  : 'user with this mobile already exists!',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            OutlinedButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text(
                                                  'Back to Login',
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .primaryColor),
                                                ))
                                          ],
                                        ));
                                  } else if (snapshot.hasError) {
                                    return Center(
                                        child: Text('${snapshot.error}'));
                                  }
                                  return Center(
                                      child: SizedBox(
                                          height: 600,
                                          width: 200,
                                          child: Center(
                                              child:
                                                  CircularProgressIndicator())));
                                })
                            : Visibility(
                                visible: issignup ? false : true,
                                child: Card(
                                    elevation: 3,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(16)),
                                    color:
                                        Theme.of(context).secondaryHeaderColor,
                                    child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            20, 10, 20, 10),
                                        child: SizedBox(
                                            height: 550,
                                            child: Form(
                                                key: _formKey,
                                                child: SingleChildScrollView(
                                                    child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .stretch,
                                                        children: [
                                                      Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 10),
                                                          child: Text(
                                                            'Name',
                                                            style: TextStyle(
                                                                fontSize: 16,
                                                                color: AppTheme
                                                                    .colors
                                                                    .primaryDark),
                                                          )),
                                                      TextFormField(
                                                          validator: (value) {
                                                            if (value.isEmpty) {
                                                              return "name can't be empty!";
                                                            }

                                                            return null;
                                                          },
                                                          controller:
                                                              nameController,
                                                          decoration:
                                                              InputDecoration(
                                                            enabledBorder:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                color: Theme.of(
                                                                        context)
                                                                    .primaryColor,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
                                                            ),
                                                            focusedBorder:
                                                                UnderlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryColor),
                                                            ),
                                                            hintText:
                                                                "your name",
                                                          )),
                                                      Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 10),
                                                          child: Text(
                                                            'Mobile',
                                                            style: TextStyle(
                                                                fontSize: 16,
                                                                color: AppTheme
                                                                    .colors
                                                                    .primaryDark),
                                                          )),
                                                      TextFormField(
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          validator: (value) {
                                                            if (value.isEmpty) {
                                                              return "mobile can't be empty!";
                                                            }

                                                            return null;
                                                          },
                                                          controller:
                                                              mobileController,
                                                          decoration:
                                                              InputDecoration(
                                                            enabledBorder:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                color: Theme.of(
                                                                        context)
                                                                    .primaryColor,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
                                                            ),
                                                            focusedBorder:
                                                                UnderlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryColor),
                                                            ),
                                                            hintText:
                                                                "+20xxxxxxxxxx",
                                                          )),
                                                      Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 10),
                                                          child: Text(
                                                            'Email',
                                                            style: TextStyle(
                                                                fontSize: 16,
                                                                color: AppTheme
                                                                    .colors
                                                                    .primaryDark),
                                                          )),
                                                      TextFormField(
                                                          validator: (value) {
                                                            if (value.isEmpty) {
                                                              return "Email can't be empty!";
                                                            }

                                                            return null;
                                                          },
                                                          controller:
                                                              mailController,
                                                          decoration:
                                                              InputDecoration(
                                                            enabledBorder:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                color: Theme.of(
                                                                        context)
                                                                    .primaryColor,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
                                                            ),
                                                            focusedBorder:
                                                                UnderlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryColor),
                                                            ),
                                                            hintText:
                                                                "yourmail@example.com",
                                                          )),
                                                      Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 10),
                                                          child: Text(
                                                            'Password',
                                                            style: TextStyle(
                                                                fontSize: 16,
                                                                color: AppTheme
                                                                    .colors
                                                                    .primaryDark),
                                                          )),
                                                      TextFormField(
                                                          validator: (value) {
                                                            if (passwordController
                                                                    .text !=
                                                                password2Controller
                                                                    .text) {
                                                              return '';
                                                            }
                                                            if (value.isEmpty) {
                                                              return "Enter your password";
                                                            }

                                                            return null;
                                                          },
                                                          controller:
                                                              passwordController,
                                                          obscureText: isChecked
                                                              ? false
                                                              : true,
                                                          decoration:
                                                              InputDecoration(
                                                            suffixIcon:
                                                                IconButton(
                                                                    onPressed:
                                                                        () {
                                                                      setState(
                                                                          () {
                                                                        isChecked =
                                                                            !isChecked;
                                                                      });
                                                                    },
                                                                    icon: Icon(isChecked
                                                                        ? Icons
                                                                            .visibility
                                                                        : Icons
                                                                            .visibility_off)),
                                                            enabledBorder:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                color: AppTheme
                                                                    .colors
                                                                    .secondry,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
                                                            ),
                                                            focusedBorder:
                                                                UnderlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: AppTheme
                                                                      .colors
                                                                      .secondry),
                                                            ),
                                                          )),
                                                      Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 10),
                                                          child: Text(
                                                            'Confirm Password',
                                                            style: TextStyle(
                                                                fontSize: 16,
                                                                color: AppTheme
                                                                    .colors
                                                                    .primaryDark),
                                                          )),
                                                      TextFormField(
                                                          validator: (value) {
                                                            if (passwordController
                                                                    .text !=
                                                                password2Controller
                                                                    .text) {
                                                              return 'Not equal password1!';
                                                            }
                                                            if (value.isEmpty) {
                                                              return "confirm your password";
                                                            }

                                                            return null;
                                                          },
                                                          controller:
                                                              password2Controller,
                                                          obscureText: true,
                                                          decoration:
                                                              InputDecoration(
                                                            enabledBorder:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                color: AppTheme
                                                                    .colors
                                                                    .secondry,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
                                                            ),
                                                            focusedBorder:
                                                                UnderlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: AppTheme
                                                                      .colors
                                                                      .secondry),
                                                            ),
                                                          )),
                                                      Padding(
                                                          padding: const EdgeInsets
                                                              .only(top: 30),
                                                          child: RaisedButton(
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              16.0)),
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor,
                                                              child: Text(
                                                                'SIGN ME UP',
                                                                style: TextStyle(
                                                                    color: Theme.of(
                                                                            context)
                                                                        .secondaryHeaderColor),
                                                              ),
                                                              onPressed:
                                                                  () async {
                                                                if (_formKey
                                                                    .currentState
                                                                    .validate()) {
                                                                  setState(() {
                                                                    issignup =
                                                                        true;
                                                                  });
                                                                }
                                                              }))
                                                    ]))))))),
                      ],
                    )))));
  }
}
