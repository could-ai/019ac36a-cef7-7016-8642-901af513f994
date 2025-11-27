class Product {
  final String id;
  String name;
  double price;
  int quantity;
  final String? qrCode;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    this.qrCode,
  });
}
