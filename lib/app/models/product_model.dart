class Product {
  final String id;
  final String name;
  final String? description;
  final String? imageUrl;
  final double price;
  final String category;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    this.description,
    this.imageUrl,
  });

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'].toString(),
      name: map['name'] ?? '',
      price: double.tryParse(map['price'].toString()) ?? 0.0,
      description: map['description'],
      imageUrl: map['image_url'],
      category: map['category'] ?? 'Uncategorized',
    );
  }
}
