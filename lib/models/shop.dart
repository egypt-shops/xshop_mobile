class Shop {
  final int id;
  final String name;
  final String mobile;

  Shop({this.id, this.name, this.mobile});

  factory Shop.fromJson(Map<String, dynamic> json) {
    return Shop(
      id: json['id'] as int,
      name: json['name'] as String,
      mobile: json['mobile'] as String,
    );
  }
}
