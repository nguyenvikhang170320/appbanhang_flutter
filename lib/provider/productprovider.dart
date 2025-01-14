import 'package:appbanhang/model/category.dart';
import 'package:appbanhang/model/products.dart';
import 'package:flutter/material.dart';

class ProductProvider extends ChangeNotifier {
  //thông báo
  List<String> notificationList = [];
  void addNotification(String notification) {
    notificationList.add(notification);
  }

  int get getNotificationIndex {
    return notificationList.length;
  }

  //search danh mục
  List<Category> searchList = [];
  Future<void> getSearchList({required List<Category> list}) async {
    print("1n");
    searchList = list;
    notifyListeners();
    return; // Thông báo cho các widget lắng nghe để cập nhật giao diện
  }

  List<Category> searchCategoryList(String query) {
    print("searchCategoryList");
    List<Category> searchShirt = searchList.where((element) {
      return element.name.toUpperCase().contains(query) ||
          element.name.toLowerCase().contains(query);
    }).toList();
    return searchShirt;
  }

  //search sản phẩm
  List<Products> searchListProduct = [];
  Future<void> getSearchListProduct(
      {required List<Products> listproduct}) async {
    print("searchListProduct");
    searchListProduct = listproduct;
    notifyListeners();
    return; // Thông báo cho các widget lắng nghe để cập nhật giao diện
  }

  List<Products> searchListProducts(String query) {
    print(11);
    List<Products> searchShirt = searchListProduct.where((element) {
      return element.name.toUpperCase().contains(query) ||
          element.name.toLowerCase().contains(query);
    }).toList();
    return searchShirt;
  }
}
