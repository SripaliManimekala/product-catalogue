class Product {
  final String id;
  final String name;
  final String description;
  final String category;
  final double price;
  final String imageUrl;

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.price,
    required this.imageUrl,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      // dummyjson's id is an int — store as String so it works as a Map/Set
      // key and a Hero tag without extra casting elsewhere in the app.
      id: json['id'].toString(),
      name: json['title'] as String,
      price: (json['price'] as num).toDouble(),
      category: json['category'] as String,
      description: json['description'] as String,
      imageUrl: json['thumbnail'] as String,
    );
  }
}
