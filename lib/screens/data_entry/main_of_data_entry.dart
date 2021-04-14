import 'package:flutter/material.dart';
import 'package:xshop_mobile/screens/home/components/General_manager.dart';
import 'package:xshop_mobile/screens/home/home.dart';
import 'product_creating.dart';
import 'search.dart';

class DataEntry extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // make search widget
    Widget search() => Container(
            child: Column(
          children: [
            Container(
                margin: EdgeInsets.fromLTRB(40, 40, 40, 0),
                decoration: BoxDecoration(
                    color: Colors.white30,
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        'Search your products',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue),
                      ),
                    ),
                    Container(
                      child: IconButton(
                        onPressed: () {
                          showSearch(context: context, delegate: Search());
                        },
                        icon: Icon(
                          Icons.search,
                          color: Colors.blue,
                          size: 25,
                        ),
                      ),
                    )
                  ],
                )),
            Container(
                margin: EdgeInsets.fromLTRB(40, 20, 40, 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (c) => ProductCreatingPage()),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white30,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
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
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (c) => ProductCreatingPage()),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white30,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                          margin: EdgeInsets.only(right: 20),
                          child: Text(
                            'Submit',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue),
                          ),
                        )),
                  ],
                )),
          ],
        ));

    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          search(),
        ],
      ),
    );
  }
} //////
