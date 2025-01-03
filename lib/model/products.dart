import 'package:cloud_firestore/cloud_firestore.dart';

class Products {
  final String idProduct;
  final String name;
  final double price;
  final String image;
  final String category;
  final String description;

  Products({
    required this.idProduct,
    required this.name,
    required this.price,
    required this.image,
    required this.category,
    required this.description,
  });

  factory Products.fromFirestore(DocumentSnapshot doc) {
    return Products(
      idProduct: doc['idProduct'] as String,
      name: doc['Name'] as String,
      price: doc['Price'] as double,
      image: doc['Image'] as String,
      category: doc['Category'] as String,
      description: doc['Description'] as String,
    );
  }
}
