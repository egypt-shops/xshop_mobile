class Order {
  final int id;
  final int user;
  final int shop;
  final bool paid;

  Order({this.id, this.user, this.shop, this.paid});

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      user: json['user'] as int,
      id: json['id'] as int,
      shop: json['shop'] as int,
      paid: json['paid'] as bool,
    );
  }
}
