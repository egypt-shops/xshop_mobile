import 'package:json_annotation/json_annotation.dart';
import 'dart:io';

import 'package:hive/hive.dart';

part 'shop.g.dart';

@JsonSerializable()
@HiveType(typeId: 1)
class Shop {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String mobile;

  Shop({this.id, this.name, this.mobile});

  factory Shop.fromJson(Map<String, dynamic> json) => _$ShopFromJson(json);

  Map<String, dynamic> toJson() => _$ShopToJson(this);

  @override
  String toString() {
    return '$name: $mobile';
  }
}
