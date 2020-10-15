import 'package:flutter/material.dart';
import 'package:xshop_mobile/screens/login/login.dart';
import 'package:xshop_mobile/services/loginAPI.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

final TextEditingController mobileController = new TextEditingController();
final TextEditingController passwordController = new TextEditingController();

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(80.0),
        color: Colors.blue[50],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'xshop',
              style: Theme.of(context).textTheme.headline2,
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Username',
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
                () {
          
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => LoginAPI(mobile: mobileController.text,password: passwordController.text,)), (Route<dynamic> route) => false);
        }
              )
            ])
          ],
        ));
  }
}