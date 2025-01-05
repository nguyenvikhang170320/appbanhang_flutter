import 'package:appbanhang/model/colorsize.dart';
import 'package:appbanhang/model/products.dart';
import 'package:flutter/material.dart';

class ProductProvider extends ChangeNotifier{
  List<ColorSize> _items = [];
  void addItem(Products product,String id, String size,String color, bool categoryRequiresSizeColor) {
    notifyListeners();
    _items.add(ColorSize(
      products: product,
      size: size,
      id: id,
      color: color, categoryRequiresSizeColor: categoryRequiresSizeColor,
    ));
  }
  List<ColorSize> get items => _items;

  // Phương thức để lấy danh sách sản phẩm cần hiển thị size và màu sắc
  List<ColorSize> get itemsWithSizeColor => _items.where((item) => item.categoryRequiresSizeColor).toList();
}
