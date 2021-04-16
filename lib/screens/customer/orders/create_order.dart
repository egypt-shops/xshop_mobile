import 'package:flutter/material.dart';
import 'package:xshop_mobile/models/order.dart';
import 'package:xshop_mobile/services/post_order.dart';

class CreateOrderScreen extends StatefulWidget {
  @override
  _CreateOrderScreenState createState() => _CreateOrderScreenState();
}

class _CreateOrderScreenState extends State<CreateOrderScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController userController = new TextEditingController();
  TextEditingController shopController = new TextEditingController();
  bool paid=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Create order"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: userController,
                      decoration: new InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: new BorderSide(color: Color(0xffF0F9FE)),
                      borderRadius: BorderRadius.circular(17),
                    ),
                    prefixIcon: Icon(Icons.person),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(17),
                      borderSide: new BorderSide(color: Colors.grey),
                    ),
                    fillColor: Color(0xffF0F9FE),
                    contentPadding: EdgeInsets.symmetric(horizontal: 22),
                    alignLabelWithHint: true,
                    labelStyle: TextStyle(
                        fontSize: 18.0,
                        //I believe the size difference here is 6.0 to account padding
                        color: Colors.grey),
                    labelText: 'User ID',
                    filled: true,
                  )),

                  TextFormField(
                    controller: shopController,
                      decoration: new InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: new BorderSide(color: Color(0xffF0F9FE)),
                          borderRadius: BorderRadius.circular(17),
                        ),
                        prefixIcon: Icon(Icons.shopping_cart),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(17),
                          borderSide: new BorderSide(color: Colors.grey),
                        ),
                        fillColor: Color(0xffF0F9FE),
                        contentPadding: EdgeInsets.symmetric(horizontal: 22),
                        alignLabelWithHint: true,
                        labelStyle: TextStyle(
                            fontSize: 18.0,
                            //I believe the size difference here is 6.0 to account padding
                            color: Colors.grey),
                        labelText: 'Shop ID',
                        filled: true,
                      )),
                  CheckboxListTile(value: paid, onChanged: (val){
                    setState(() {
                      paid =!paid;
                    });
                  }),
                  ElevatedButton(onPressed: () async {
                    String userID = userController.text;
                    String shopID = shopController.text;
                    Order order = await PostOrder().createOrder( userID, shopID, paid);
                    print("############################################ ${order.id}");
                  },child: Text("Submit"), )
                ],
              )),
        ));
  }
}
