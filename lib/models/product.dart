import 'package:json_annotation/json_annotation.dart';
import 'dart:io';

import 'package:hive/hive.dart';

part 'product.g.dart';

@JsonSerializable()
@HiveType(typeId: 1)
class Product {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String price;
  @HiveField(3)
  final int stock;

  Product({this.id, this.name, this.price, this.stock});
  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);

  @override
  String toString() {
    return '$name: $price';
  }
}
