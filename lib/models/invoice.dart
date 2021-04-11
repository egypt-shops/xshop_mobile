class Invoice {
  final int id;
  final int user;
  final int order;

  Invoice({this.id, this.user, this.order});

  factory Invoice.fromJson(Map<String, dynamic> json) {
    return Invoice(
      id: json['id'] as int,
      user: json['user'] as int,
      order: json['order'] as int,
    );
  }
}
