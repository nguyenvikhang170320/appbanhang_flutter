import 'package:appbanhang/model/products.dart';

class ProductDetail {
  final String size;
  final String color;
  int quantity;

  ProductDetail({
   required this.size,
    required this.color,
    required this.quantity,
  });
}

class ProductWithDetail extends Products {
  final ProductDetail detail;

  ProductWithDetail({
    required super.idProduct,
    required super.name,
    required super.category,
    required super.price,
    required super.image,
    required super.description,
    required this.detail,
  });
}

