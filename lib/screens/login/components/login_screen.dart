import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Password',
                ),
                obscureText: true,
              ),
              SizedBox(
                height: 24,
              ),
              RaisedButton(
                color: Colors.blue[500],
                child: Text('LOGIN'),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/home');
                },
              )
            ])
          ],
        ));
  }
}

Future<http.Response> fetchAlbum() {
  return http.get('https://jsonplaceholder.typicode.com/albums/1');
}
