// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cart _$CartFromJson(Map<String, dynamic> json) {
  return Cart(
    quantity: json['quantity'] as int,
    price: json['price'] as String,
    product: json['product'] == null
        ? null
        : Product.fromJson(json['product'] as Map<String, dynamic>),
    totalprice: json['totalprice'] as String,
  );
}

Map<String, dynamic> _$CartToJson(Cart instance) => <String, dynamic>{
      'quantity': instance.quantity,
      'price': instance.price,
      'product': instance.product?.toJson(),
      'totalprice': instance.totalprice,
    };
