class Product {
  final int id;
  final String name;
  final String price;
  final int stock;

  Product({this.id, this.name, this.price, this.stock});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int,
      name: json['name'] as String,
      price: json['price'] as String,
      stock: json['stock'] as int,
    );
  }
}
