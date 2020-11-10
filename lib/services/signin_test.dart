
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignIn {
var jsonResponse = null;
Future<User> signIn(mobile, pass) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {
      'mobile': mobile,
      'password': pass
    };
    var  response = await http.post("https://dev-egshops.herokuapp.com/api/users/token/", body: data);
    print(response.statusCode);
    if(response.statusCode == 200) {
      jsonResponse = json.decode(response.body);

      if(jsonResponse != null) {
        print(jsonResponse['user']);
        sharedPreferences.setString("token", jsonResponse['token']);
        User user_data= User.fromJson( jsonResponse['user']);
        sharedPreferences.setString('name', user_data.name);
        sharedPreferences.setString('mobile', user_data.mobile);
        sharedPreferences.setString('email', user_data.email);
        return user_data;
        
      }
    }
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