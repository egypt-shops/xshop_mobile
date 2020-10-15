import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xshop_mobile/screens/home/home.dart';
import 'package:xshop_mobile/screens/login/login.dart';


class LoginAPI extends StatefulWidget {
  final String mobile;
  final String password;
  LoginAPI({this.mobile,this.password});

  @override
  _LoginAPIState createState() => _LoginAPIState();
}
class _LoginAPIState extends State<LoginAPI> {
   bool _isLoading ;

@override
void initState() {
    super.initState();
    _isLoading=true;
    this.signIn(widget.mobile, widget.password);
}

 

  @override
  Widget build(BuildContext context) {

    return Center(child: 
    CircularProgressIndicator());
  }

  signIn(String email, pass) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {
      'mobile': email,
      'password': pass
    };
    var jsonResponse = null;
    var response = await http.post("https://dev-egshops.herokuapp.com/api/users/token/", body: data);
    if(response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if(jsonResponse != null) {
        setState(() {
          _isLoading = false;
        });
        sharedPreferences.setString("token", jsonResponse['token']);
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => Home()), (Route<dynamic> route) => false);
      }
    }
    else {
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => Login()), (Route<dynamic> route) => false);
      print(response.body);
    }
  }
}
/*
 Future<User> signIn(String mobile, pass) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {
      'mobile': mobile,
      'password': pass
    };
    print('helllo');
    var jsonResponse = null;
    final http.Response response = await http.post("https://dev-egshops.herokuapp.com/api/users/login/", body: data);
    if(response.statusCode == 200) {
      jsonResponse = jsonDecode(response.body);
      if(jsonResponse != null) {
        print(jsonResponse);
        sharedPreferences.setString("token", jsonResponse['token']);
        print("sucesssssssss");
        return User.fromJson( jsonResponse['user']);
        
      }
    }
    else {
   
      print('faildddddddd');
      print(jsonResponse);
      return null;
    }
  }
class User {
  final String name;
  final String mobile;
  final String email;

  User({this.name, this.mobile,this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      mobile: json['mobile'],
      email: json['email']
    );
  }
}
*/