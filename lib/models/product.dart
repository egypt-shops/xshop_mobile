class Product {
  final String name;
  final String price;

  Product({this.name, this.price});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'] as String,
      price: json['price'] as String,
    );
  }
}
