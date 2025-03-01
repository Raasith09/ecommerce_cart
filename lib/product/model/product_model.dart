class Product {
  final int id;
  final String title;
  final String image;
  final double price;
  final String description;
  final String category;
  final Rating rating;
  int quantity; // New field for cart quantity

  Product({
    required this.id,
    required this.title,
    required this.image,
    required this.price,
    required this.description,
    required this.category,
    required this.rating,
    this.quantity = 1, // Default quantity
  });

  // Convert Product object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'image': image,
      'price': price,
      'description': description,
      'category': category,
      'rating': rating.toJson(),
      'quantity': quantity,
    };
  }

  // Convert JSON to Product object
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      image: json['image'],
      price: json['price'].toDouble(),
      description: json['description'],
      category: json['category'],
      rating: Rating.fromJson(json['rating']),
      quantity: json['quantity'] ?? 1, // Load quantity if available
    );
  }

  // Copy product with updated values
  Product copyWith({int? quantity}) {
    return Product(
      id: id,
      title: title,
      image: image,
      price: price,
      description: description,
      category: category,
      rating: rating,
      quantity: quantity ?? this.quantity,
    );
  }
}

class Rating {
  final double rate;
  final int count;

  Rating({required this.rate, required this.count});

  Map<String, dynamic> toJson() => {'rate': rate, 'count': count};

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      rate: json['rate'].toDouble(),
      count: json['count'],
    );
  }
}
