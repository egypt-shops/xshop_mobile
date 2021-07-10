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
  @HiveField(3)
  final String dashboard_modules;
  @HiveField(4)
  final String subdomain;

  Shop(
      {this.id,
      this.name,
      this.mobile,
      this.dashboard_modules,
      this.subdomain});

  factory Shop.fromJson(Map<String, dynamic> json) => _$ShopFromJson(json);

  Map<String, dynamic> toJson() => _$ShopToJson(this);

  @override
  String toString() {
    return '$name: $mobile';
  }
}
