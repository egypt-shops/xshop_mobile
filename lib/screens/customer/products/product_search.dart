import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:xshop_mobile/screens/customer/products/products.dart';
import 'package:xshop_mobile/models/product.dart';

class ProductSearch extends SearchDelegate {
  ProductSearch(this.products);
  final List<Product> products;
  final List<Product> productsHistory = [];

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(
          Icons.close,
        ),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  String selectedResult = "";

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      child: Center(
        child: Text(selectedResult),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<Product> suggestions = query.isEmpty
        ? products
        : products
            .where((element) =>
                element.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
    if (suggestions != null)
      return Scaffold(
          body:
              CustomScrollView(slivers: [ProductsList(products: suggestions)]));
    else {
      return Center(
        child: Text('no products'),
      );
    }
  }
}
