import 'package:flutter/material.dart';
import 'package:xshop_mobile/screens/home/components/General_manager.dart';
import 'package:xshop_mobile/screens/home/home.dart';
import 'product_creating.dart';
import 'search.dart';

class DataEntry extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MaindataEntryPage());
  }
}

class MaindataEntryPage extends StatelessWidget {
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
                                builder: (c) => PrductCreatingPage()),
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
                                builder: (c) => PrductCreatingPage()),
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

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.blue[50],
        appBar: AppBar(
          title: Row(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                child: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (c) => Home()),
                    );
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
          actions: [IconButton(icon: Icon(Icons.account_box), onPressed: null)],
        ),
        body: ListView(
          children: [
            search(),
          ],
        ),
      ),
    );
  }
} //////
