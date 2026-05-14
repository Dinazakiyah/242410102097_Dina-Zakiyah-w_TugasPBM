class Product {
  final int id;
  final String name;
  final double price;
  final String description;
  final String createdAt;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.createdAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      price: double.tryParse(json['price'].toString()) ?? 0.0,
      description: json['description'] ?? '',
      createdAt: json['created_at'] ?? '',
    );
  }

  String get formattedPrice {
    final number = price.toInt();
    final str = number.toString();
    final buffer = StringBuffer();
    int count = 0;
    for (int i = str.length - 1; i >= 0; i--) {
      if (count > 0 && count % 3 == 0) buffer.write('.');
      buffer.write(str[i]);
      count++;
    }
    return 'Rp ${buffer.toString().split('').reversed.join()}';
  }
}