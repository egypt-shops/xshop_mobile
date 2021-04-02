class Shop {
  final String name;

  Shop({this.name});

  factory Shop.fromJson(Map<String, dynamic> json) {
    return Shop(
      name: json['name'] as String,
    );
  }
}
