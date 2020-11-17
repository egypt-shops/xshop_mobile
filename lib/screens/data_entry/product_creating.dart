import 'package:flutter/material.dart';

//PrductCreatingPage
class PrductCreatingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: Colors.black26,
          appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                  child: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Container(
                  child: Text(
                    'home',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  padding: EdgeInsets.only(right: 20),
                ),
                Container(
                  child: Text(
                    'shop',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  padding: EdgeInsets.only(right: 20),
                ),
                Container(
                  child: Text(
                    'help',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  padding: EdgeInsets.only(right: 20),
                ),
              ],
            ),
            actions: [
              IconButton(icon: Icon(Icons.account_box), onPressed: null)
            ],
          ),
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
                                      margin:
                                          EdgeInsets.fromLTRB(0, 10, 10, 10),
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
                                              autofocus: true,
                                              maxLength: 20,
                                              maxLines: 1,
                                              style: TextStyle(
                                                  color: Colors.black),
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
                                      margin:
                                          EdgeInsets.fromLTRB(0, 10, 10, 10),
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
                                              autofocus: true,
                                              maxLength: 5,
                                              keyboardType:
                                                  TextInputType.number,
                                              maxLines: 1,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.black),
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
                                      margin:
                                          EdgeInsets.fromLTRB(0, 10, 10, 10),
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
                                              autofocus: true,
                                              maxLength: 85,
                                              maxLines: 2,
                                              style: TextStyle(
                                                  color: Colors.black),
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
                                      margin:
                                          EdgeInsets.fromLTRB(0, 10, 10, 10),
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
                                              autofocus: true,
                                              maxLength: 100,
                                              maxLines: 3,
                                              style: TextStyle(
                                                  color: Colors.black),
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
                        onTap: () {},
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white30,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                          margin: EdgeInsets.only(right: 20),
                          child: Text(
                            'Create',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue),
                          ),
                        )),
                    GestureDetector(
                        onTap: () {},
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white30,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                          margin: EdgeInsets.only(right: 20),
                          child: Text(
                            'save',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue),
                          ),
                        )),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
