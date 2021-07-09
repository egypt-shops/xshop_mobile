import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:xshop_mobile/theme/apptheme.dart';

class Profile extends StatelessWidget {
  final String name;
  final String email;
  final String phone;
  final String type;
  Profile({this.name, this.email, this.phone, this.type});
  @override
  Widget build(BuildContext context) {
    TextEditingController _mobileController =
        TextEditingController(text: '$phone');
    TextEditingController _nameController =
        TextEditingController(text: 'Mohamed Boyka');
    TextEditingController _emailController =
        TextEditingController(text: '$email');

    // alert dialog
    createAlertDialog(BuildContext context) {
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                'Edit Profile',
                style: TextStyle(fontSize: 18.0, fontStyle: FontStyle.normal),
              ),
              content: Container(
                height: 160,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _mobileController,
                      decoration: InputDecoration(
                        hintText: 'mobile  ',
                      ),
                    ),
                    TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          hintText: 'name  ',
                        )),
                    TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          hintText: 'email  ',
                        ))
                  ],
                ),
              ),
              actions: <Widget>[
                FlatButton(
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    autofocus: true,
                    focusColor: Theme.of(context).primaryColor,
                    child: new Text("Save"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    })
              ],
            );
          });
    }

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios,
                  color: Theme.of(context).primaryColor),
              onPressed: () {
                Navigator.pop(context);
              }),
          actions: [
            IconButton(
                icon: Icon(Icons.edit, color: Theme.of(context).primaryColor),
                onPressed: () {
                  createAlertDialog(context);
                })
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 20.0,
                ),
                CircleAvatar(
                  backgroundImage: AssetImage('images/an.jpg'),
                  radius: 42,
                ),
                SizedBox(
                  width: 20.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Mohamed Boyka',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Opacity(
                      opacity: 0.7,
                      child: Text(
                        '$type',
                        style: TextStyle(
                            fontSize: 12.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 6.0),
              child: ListTile(
                leading: Icon(
                  Icons.phone,
                ),
                title: Text(
                  '$phone',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 6.0),
              child: ListTile(
                leading: Icon(
                  Icons.mail,
                ),
                title: Text(
                  '$email',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
