import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignIn {
  var jsonResponse;
  Future<User> signIn(mobile, pass) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {'mobile': mobile, 'password': pass};
    var response = await http.post(
        Uri.parse("https://dev-egshops.herokuapp.com/api/users/token/"),
        body: data);
    print(response.statusCode);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);

      if (jsonResponse != null) {
        print(jsonResponse['user']);
        sharedPreferences.setString("token", jsonResponse['token']);
        User user_data = User.fromJson(jsonResponse['user']);
        sharedPreferences.setString('type', user_data.type);
        sharedPreferences.setString('mobile', user_data.mobile);
        sharedPreferences.setString('email', user_data.email);
        return user_data;
      }
    }
    return null;
  }
}

class User {
  final String type;
  final String mobile;
  final String email;

  User({this.type, this.mobile, this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    String userType = 'empty';

    if (json['type'].length != 0) userType = json['type'][0];
    return User(type: userType, mobile: json['mobile'], email: json['email']);
  }
}
