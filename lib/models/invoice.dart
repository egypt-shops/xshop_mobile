class Invoice {
  final int user;
  final int order;

  Invoice({this.user, this.order});

  factory Invoice.fromJson(Map<String, dynamic> json) {
    return Invoice(
      user: json['user'] as int,
      order: json['order'] as int,
    );
  }
}
