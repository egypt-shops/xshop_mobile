import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Center(
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Text("login successfully",
            style: Theme.of(context).textTheme.headline4),
        RaisedButton(
            color: Colors.blue,
            child: Text('LOGOUT'),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/');
            })
      ]),
    ));
  }
}
