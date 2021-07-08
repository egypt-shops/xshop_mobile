import 'package:flutter/material.dart';
import 'package:xshop_mobile/models/product.dart';
import 'package:xshop_mobile/models/shop.dart';

/// The [Favorites] class holds a list of favorite items saved by the user.
class FavoritesShops extends ChangeNotifier {
  final List<Shop> _favoriteItems = [];

  List<Shop> get items => _favoriteItems;

  void add(Shop itemNo) {
    _favoriteItems.add(itemNo);
    notifyListeners();
  }

  void remove(Shop itemNo) {
    _favoriteItems.remove(itemNo);
    notifyListeners();
  }
}

class FavoritesProducts extends ChangeNotifier {
  final List<Product> _favoriteItems = [];

  List<Product> get items => _favoriteItems;

  void add(Product itemNo) {
    _favoriteItems.add(itemNo);
    notifyListeners();
  }

  void remove(Product itemNo) {
    _favoriteItems.remove(itemNo);
    notifyListeners();
  }
}
