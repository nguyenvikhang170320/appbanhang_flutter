import 'package:flutter/material.dart';

class OrderProvider extends ChangeNotifier {
  bool orderConfirmed = false;
  String confirmedOrderId = '';
  Map<String, dynamic> confirmedOrderData = {};

  void updateOrder(bool confirmed, String orderId, Map<String, dynamic> orderData,  List<Map<String, dynamic>> productsData) {
    orderConfirmed = confirmed;
    confirmedOrderId = orderId;
    confirmedOrderData = {
      ...orderData,
      'products': productsData,
    };
    print(confirmedOrderData);
    notifyListeners();
  }

  void clearOrder() {
    orderConfirmed = false;
    confirmedOrderId = '';
    confirmedOrderData = {};
    notifyListeners();
  }
}