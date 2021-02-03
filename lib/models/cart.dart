import 'package:flutter/material.dart';
import 'package:xshop_mobile/models/product.dart';

/// The [CartModel] class holds a list of cart items saved by the user.
class CartModel extends ChangeNotifier {
  final List<Product> _cartItems = [];

  List<Product> get items => _cartItems;

  void add(Product product) {
    _cartItems.add(product);
    notifyListeners();
  }

  void remove(Product product) {
    _cartItems.remove(product);
    notifyListeners();
  }
}
