import 'package:cloud_firestore/cloud_firestore.dart';

class Products {
  final String name;
  final double price;
  final String image;
  final String category; // New field for product category
  final String description; // New field for product description

  Products({
    required this.name,
    required this.price,
    required this.image,
    required this.category,
    required this.description,
  });

  factory Products.fromFirestore(DocumentSnapshot doc) {
    return Products(
      name: doc['Name'] as String,
      price: doc['Price'] as double,
      image: doc['Image'] as String,
      category: doc['Category'] as String, // Access new field from doc
      description: doc['Description'] as String, // Access new field from doc
      // Access new field from doc
    );
  }
}
