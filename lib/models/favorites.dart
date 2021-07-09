import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:xshop_mobile/models/product.dart';
import 'package:xshop_mobile/models/shop.dart';

/// The [Favorites] class holds a list of favorite items saved by the user.
class FavoritesShops extends ChangeNotifier {
  final String _dbKey = 'shopList';
  Box _db;
  final List<dynamic> _favoriteItems = [];
  // Constructor
  FavoritesShops(Box db) {
    _db = db;
    List<dynamic> shopList = _db.containsKey(_dbKey) ? _db.get(_dbKey) : [];
    makeList(shopList);
  }

  // dynamic to model translator
  void makeList(List<dynamic> shopList) {
    shopList.forEach((item) => _favoriteItems.add(item));
  }

  // model to dynamic translator, to save to DB
  List<dynamic> todoListToShopList() {
    List<dynamic> shopList = [];
    _favoriteItems.forEach((item) => shopList.add(item));
    return shopList;
  }

  List<dynamic> get items => _favoriteItems;

  void add(dynamic itemNo) {
    _favoriteItems.add(itemNo);
    _db.put(_dbKey, todoListToShopList());
    notifyListeners();
  }

  void remove(dynamic itemNo) {
    _favoriteItems.remove(itemNo);
    _db.put(_dbKey, todoListToShopList());
    notifyListeners();
  }
}

class FavoritesProducts extends ChangeNotifier {
  final String _dbKey = 'productList';
  Box _db;
  final List<dynamic> _favoriteItems = [];
  // Constructor
  FavoritesProducts(Box db) {
    _db = db;
    List<dynamic> productList = _db.containsKey(_dbKey) ? _db.get(_dbKey) : [];
    makeList(productList);
  }

  // dynamic to model translator
  void makeList(List<dynamic> productList) {
    productList.forEach((item) => _favoriteItems.add(item));
  }

  // model to dynamic translator, to save to DB
  List<dynamic> todoListToProductList() {
    List<dynamic> productList = [];
    _favoriteItems.forEach((item) => productList.add(item));
    return productList;
  }

  List<dynamic> get items => _favoriteItems;

  void add(dynamic itemNo) {
    _favoriteItems.add(itemNo);
    _db.put(_dbKey, todoListToProductList());
    notifyListeners();
  }

  void remove(dynamic itemNo) {
    _favoriteItems.remove(itemNo);
    _db.put(_dbKey, todoListToProductList());
    notifyListeners();
  }
}
