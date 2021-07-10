import 'package:flutter/material.dart';
import 'package:xshop_mobile/models/product.dart';
import 'package:xshop_mobile/services/products.dart';
import 'package:http/http.dart' as http;

//ProductCreatingPage
class ProductCreatingPage extends StatefulWidget {
  @override
  _ProductCreatingPageState createState() => _ProductCreatingPageState();
}

class _ProductCreatingPageState extends State<ProductCreatingPage> {
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = new TextEditingController();
    final TextEditingController priceController = new TextEditingController();
    final TextEditingController stockController = new TextEditingController();
    final TextEditingController descriptionController =
        new TextEditingController();

    return MaterialApp(
      home: Scaffold(
        body: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [],
                ),
                Expanded(
                  child: Container(
                      margin: EdgeInsets.fromLTRB(20, 30, 30, 20),
                      width: 500,
                      decoration: BoxDecoration(
                          color: Colors.white30,
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // for row of name and its text field
                          Container(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // for name label
                                Container(
                                  margin: EdgeInsets.fromLTRB(10, 20, 10, 10),
                                  height: 100,
                                  child: Column(children: [
                                    Text(
                                      'name :',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ]),
                                ),
                                // for textfield of name
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.fromLTRB(0, 10, 10, 10),
                                    width: 250,
                                    height: 85,
                                    decoration: BoxDecoration(
                                        color: Colors.white30,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8))),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        TextField(
                                            controller: nameController,
                                            key: Key('name_controller'),
                                            autofocus: true,
                                            maxLength: 20,
                                            maxLines: 1,
                                            style:
                                                TextStyle(color: Colors.black),
                                            decoration: InputDecoration(
                                                border: OutlineInputBorder()))
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // for row of name and its text field
                          Container(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // for price label
                                Container(
                                  margin: EdgeInsets.fromLTRB(10, 20, 10, 10),
                                  height: 100,
                                  child: Column(children: [
                                    Text(
                                      'Price :',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ]),
                                ),
                                // for textfield of name
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.fromLTRB(0, 10, 10, 10),
                                    width: 250,
                                    decoration: BoxDecoration(
                                        color: Colors.white30,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8))),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        TextField(
                                            key: Key('price_controller'),
                                            controller: priceController,
                                            autofocus: true,
                                            maxLength: 5,
                                            keyboardType: TextInputType.number,
                                            maxLines: 1,
                                            textAlign: TextAlign.center,
                                            style:
                                                TextStyle(color: Colors.black),
                                            decoration: InputDecoration(
                                                border: OutlineInputBorder()))
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // for price label
                                Container(
                                  margin: EdgeInsets.fromLTRB(10, 20, 10, 10),
                                  height: 100,
                                  child: Column(children: [
                                    Text(
                                      'stock :',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ]),
                                ),
                                // for textfield of name
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.fromLTRB(0, 10, 10, 10),
                                    width: 250,
                                    decoration: BoxDecoration(
                                        color: Colors.white30,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8))),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        TextField(
                                            key: Key('stock_controller'),
                                            controller: stockController,
                                            autofocus: true,
                                            maxLength: 5,
                                            keyboardType: TextInputType.number,
                                            maxLines: 1,
                                            textAlign: TextAlign.center,
                                            style:
                                                TextStyle(color: Colors.black),
                                            decoration: InputDecoration(
                                                border: OutlineInputBorder()))
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ), // for row of description and its text field
                          Container(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // for description label
                                Container(
                                  margin: EdgeInsets.fromLTRB(10, 20, 10, 10),
                                  height: 100,
                                  child: Column(children: [
                                    Text(
                                      'description :',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ]),
                                ),
                                // for textfield of description
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.fromLTRB(0, 10, 10, 10),
                                    width: 250,
                                    decoration: BoxDecoration(
                                        color: Colors.white30,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8))),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        TextField(
                                            controller: descriptionController,
                                            key: Key('description_controller'),
                                            autofocus: true,
                                            maxLength: 85,
                                            maxLines: 2,
                                            style:
                                                TextStyle(color: Colors.black),
                                            decoration: InputDecoration(
                                                border: OutlineInputBorder()))
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // for row of specification and its text field
                          Container(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // for specification label
                                Container(
                                  margin: EdgeInsets.fromLTRB(10, 20, 10, 10),
                                  height: 100,
                                  child: Column(children: [
                                    Text(
                                      'specification :',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ]),
                                ),
                                // for textfield of specification
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.fromLTRB(0, 10, 10, 10),
                                    width: 250,
                                    decoration: BoxDecoration(
                                        color: Colors.white30,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8))),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        TextField(
                                            key:
                                                Key('specification_controller'),
                                            autofocus: true,
                                            maxLength: 100,
                                            maxLines: 3,
                                            style:
                                                TextStyle(color: Colors.black),
                                            decoration: InputDecoration(
                                                border: OutlineInputBorder()))
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          /// asking for adding image of product
                          Container(
                            padding: EdgeInsets.fromLTRB(40, 40, 40, 100),
                            margin: EdgeInsets.fromLTRB(20, 30, 20, 20),
                            decoration: BoxDecoration(
                                color: Colors.white30,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                            child: Text(
                              'add image of product',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      )),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.fromLTRB(40, 40, 40, 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                      onTap: () {
                        _handleSubmit(context, nameController.text,
                            priceController.text, stockController.text,descriptionController.text);
                      },
                      key: Key('Create_Product'),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white30,
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                        margin: EdgeInsets.only(right: 20),
                        child: Text(
                          'Create',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor),
                        ),
                      )),
                  GestureDetector(
                      onTap: () {},
                      key: Key('save_Product'),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white30,
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                        margin: EdgeInsets.only(right: 20),
                        child: Text(
                          'save',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor),
                        ),
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _handleSubmit(
      BuildContext context, String name, String price, String stock,String description) async {
    try {
      Dialogs.showLoadingDialog(context, _keyLoader); //invoking login
      Product response =
          await postProducts(http.Client(), name, price, stock, description);

      // Find the ScaffoldMessenger in the widget tree
      // and use it to show a SnackBar.
      if (response == null) {
        Scaffold.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text('product not added'),
        ));
      } else {
        Scaffold.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.green,
          content: Text('product added successfully'),
          /*action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              // Some code to undo the change.
            },
          ),*/
        ));
      }
      Navigator.of(_keyLoader.currentContext, rootNavigator: true)
          .pop(); //close the dialoge

    } catch (error) {
      print(error);
    }
  }
}

class Dialogs {
  static Future<void> showLoadingDialog(
      BuildContext context, GlobalKey key) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(
                  key: key,
                  backgroundColor: Colors.black54,
                  children: <Widget>[
                    Center(
                      child: Column(children: [
                        CircularProgressIndicator(),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Please Wait....",
                          style: TextStyle(color: Colors.blueAccent),
                        )
                      ]),
                    )
                  ]));
        });
  }
}
