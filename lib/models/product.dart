class Product {
  int id;
  String name;
  String description;
  double price;
  double stok;

  Product({required this.id, required this.name, required this.description, required this.price, required this.stok});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'].toDouble(),
      stok: json['stok'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'stok': stok,
    };
  }
}
