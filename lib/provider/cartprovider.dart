import 'package:appbanhang/model/cartitem.dart';
import 'package:appbanhang/model/products.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CartProvider extends ChangeNotifier {
  List<CartItem> _items = [];

  void addItem(Products product, String size, int quantity, String color) {
    notifyListeners();
    _items.add(CartItem(
      products: product,
      size: size,
      quantity: quantity,
      color: color,
    ));
  }

  List<CartItem> get items => _items;

  //xóa giỏ hàng
  void removeItem(CartItem item) {
    _items.removeWhere((cartItem) => cartItem == item);
    notifyListeners();
  }

//format tổng tiền ban đầu về VNĐ
  String get formattedPrice {
    final locale = 'vi_VN';
    final formatter = NumberFormat.currency(locale: locale);
    return formatter.format(subTotalPrice);
  }
  //format tong tien về VNĐ
  String get formattedTotalPrice {
    final locale = 'vi_VN';
    final formatter = NumberFormat.currency(locale: locale);
    return formatter.format(totalPrice);
  }

  //tổng tiền ban đầu
  double get subTotalPrice {
    return _items.fold(
        0, (total, item) => total + item.products.price * item.quantity);
  }
  String _discountColor = ""; // Mặc định là 0% (không giảm giá)

  String get discountColor => _discountColor;

  set discountColor(String newRate) {
    _discountColor = newRate;
    notifyListeners();
  }

  //giảm giá %
  double _discountRate = 0.0; // Mặc định là 0% (không giảm giá)

  double get discountRate => _discountRate;

  double get discount {
    return subTotalPrice * _discountRate;
  }

  //tổng tiền
  double get totalPrice {
    final subTotal = this.subTotalPrice;
    final discount = this.discount;
    return subTotal - discount + shipCode(subTotal);
  }

  //shipcode
  double shipCode(double subTotal) {
    // Thay đổi đơn vị tiền tệ thành USD
    const double usdPerVND =
        25.429; // Tỷ giá USD/VND (bạn có thể thay đổi giá trị này)
    // Chuyển đổi tổng tiền sang USD
    double subTotalUSD = subTotal * usdPerVND;
    // Logic tính phí vận chuyển theo USD
    if (subTotalUSD <= 2) {
      return 0; // Miễn phí ship nếu đơn hàng trên 10 USD
    } else if (subTotalUSD > 2 && subTotalUSD < 10) {
      return 1.5; // Phí ship 1.5 USD
    } else {
      return 2;
    }
  }
  //shipcode cách 2 ngắn hơn
  // double get shipCode {
  //   // Giả sử phí vận chuyển cố định là 1.5$ khi có sản phẩm trong giỏ hàng
  //   return _items.isNotEmpty ? 1.5 : 0.0;
  // }
  double calculateTotalPrice() {
    return subTotalPrice - discount + shipCode(subTotalPrice);
  }

}
