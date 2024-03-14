class Product {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;

  const Product(
      {required this.category,
      required this.description,
      required this.price,
      required this.id,
      required this.image,
      required this.title});

  factory Product.fromjson(Map<String, dynamic> json) {
    return Product(
        category: json['category'],
        description: json['description'],
        price: double.parse(json['price'].toString()),
        id: json['id'],
        image: json['image'],
        title: json['title']);
  }
}
