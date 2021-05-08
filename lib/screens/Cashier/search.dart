import 'package:flutter/material.dart';
import 'package:xshop_mobile/models/product.dart';
import 'package:xshop_mobile/screens/customer/products/products.dart';
import 'package:xshop_mobile/services/products.dart';

class SearchList extends StatefulWidget {
  SearchList({Key key}) : super(key: key);
  @override
  _SearchListState createState() => new _SearchListState();
}

class _SearchListState extends State<SearchList> {
  Widget appBarTitle;
  Icon actionIcon;
  final key = new GlobalKey<ScaffoldState>();
  final TextEditingController _searchQuery = new TextEditingController();
  List<Product> _list;
  bool _isSearching;
  String _searchText = "";

  _SearchListState() {
    _searchQuery.addListener(() {
      if (_searchQuery.text.isEmpty) {
        setState(() {
          _isSearching = false;
          _searchText = "";
        });
      } else {
        setState(() {
          _isSearching = true;
          _searchText = _searchQuery.text;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _isSearching = false;
    init();
  }

  void init() {
    _list = products;
    this.actionIcon = new Icon(
      Icons.close,
      color: Colors.amber,
    );
    this.appBarTitle = new TextField(
        controller: _searchQuery,
        style: new TextStyle(color: Colors.amber),
        decoration: new InputDecoration(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.amber),
          ),
          hintText: "Search by name",
        ));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: key,
      appBar: AppBar(
          iconTheme: IconThemeData(
            color: Theme.of(context).primaryColor, //change your color here
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          title: appBarTitle,
          actions: <Widget>[
            new IconButton(
              icon: actionIcon,
              onPressed: () {
                _searchQuery.clear();
              },
            )
          ]),
      body: new ListView(
        padding: new EdgeInsets.symmetric(vertical: 8.0),
        children: _isSearching ? _buildSearchList() : _buildList(),
      ),
    );
  }

  List<ChildItem> _buildList() {
    return _list.map((contact) => new ChildItem(contact)).toList();
  }

  List<ChildItem> _buildSearchList() {
    if (_searchText.isEmpty) {
      return _list.map((contact) => new ChildItem(contact)).toList();
    } else {
      List<Product> _searchList = [];
      for (int i = 0; i < _list.length; i++) {
        Product product = _list.elementAt(i);
        if (product.name.toLowerCase().contains(_searchText.toLowerCase())) {
          _searchList.add(product);
        }
      }
      return _searchList.map((contact) => new ChildItem(contact)).toList();
    }
  }
}

class ChildItem extends StatelessWidget {
  final Product product;
  ChildItem(this.product);
  @override
  Widget build(BuildContext context) {
    return new ListTile(
      title: new Text(this.product.name),
      leading: IconButton(
        icon: Icon(Icons.add_shopping_cart),
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('should add product id: ${this.product.id}'),
              duration: Duration(seconds: 1),
            ),
          );
        },
      ),
    );
  }
}
