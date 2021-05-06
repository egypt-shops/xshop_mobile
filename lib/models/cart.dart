import 'product.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cart.g.dart';

@JsonSerializable(explicitToJson: true)
class Cart {
  final int quantity;
  final String price;
  final Product product;
  final String totalprice;

  Cart({this.quantity, this.price, this.product, this.totalprice});

  factory Cart.fromJson(Map<String, dynamic> json) => _$CartFromJson(json);

  Map<String, dynamic> toJson() => _$CartToJson(this);
}
