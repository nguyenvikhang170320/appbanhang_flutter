import 'package:appbanhang/model/cartitem.dart';
import 'package:appbanhang/model/products.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Orders{
  final String idCart;
  final Timestamp createAt;
  final int soluongdadat;
  final Products products;
  final String status;
  final String thanhtoan;
  final double totalAmount;
  final String userId;

  Orders({required this.idCart,required this.createAt,required this.soluongdadat,required this.products,required this.status,required
      this.thanhtoan,required this.totalAmount,required this.userId});

}