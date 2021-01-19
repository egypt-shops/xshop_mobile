import 'package:flutter/material.dart';
import 'package:xshop_mobile/services/products.dart';

class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(title: Text("Products"), actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.search,
                  size: 30,
                  color: Colors.white,
                ),
                tooltip: 'Search',
                onPressed: null,
              ),
            ]),
            body: ProductPage()
            /* 
      Container(
        padding: const EdgeInsets.all(10),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          SizedBox(
            height: 5,
          ),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              hintText: 'Search',
              icon: Icon(
                Icons.search,
              ),
            ),
          ),
        ]),
      ),
   */
            ));
  }
}

// var response = await http.get('url');
// var decodedData = jsonDecode(response.toString());
