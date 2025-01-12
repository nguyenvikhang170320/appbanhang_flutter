import 'package:cloud_firestore/cloud_firestore.dart';

class Category {
  final String name;
  final String image;

  Category({required this.name, required this.image});

  factory Category.fromFirestore(DocumentSnapshot doc) {
    return Category(
      name: doc['Name'] as String,
      image: doc['Image'] as String,
    );
  }
}
