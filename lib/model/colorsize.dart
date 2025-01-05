import 'package:appbanhang/model/products.dart';

class ColorSize {
  final Products products;
  final String id;
  final String size;
  final String color;
  final bool categoryRequiresSizeColor;

  ColorSize({
    required this.products,
    required this.id,
    required this.size,
    required this.color,
    required this.categoryRequiresSizeColor,
  });

}
