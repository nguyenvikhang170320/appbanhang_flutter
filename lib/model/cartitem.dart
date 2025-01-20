import 'package:appbanhang/model/products.dart';

class CartItem {
  final Products products;
  final String size;
  final String color;
  int quantity;

  CartItem({
    required this.products,
    required this.size,
    required this.color,
    required this.quantity,
  });

}
