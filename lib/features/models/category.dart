

import 'package:android_std/features/models/product.dart';

class Category {
  final String id;
  final String name;
  final String image;
  final String description;
  final List<Product> products;
  final String type;

  Category({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.products,
    required this.type,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      description: json['description'],
      type:  json['type'],
      products: (json['products'] as List)
          .map((product) => Product.fromJson(product))
          .toList(),
    );
  }
}