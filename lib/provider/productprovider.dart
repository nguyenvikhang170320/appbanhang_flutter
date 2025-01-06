import 'package:appbanhang/model/colorsize.dart';
import 'package:appbanhang/model/products.dart';
import 'package:flutter/material.dart';

class ProductProvider extends ChangeNotifier{
  //thông báo
  List<String> notificationList = [];
  void addNotification (String notification){
    notificationList.add(notification);
  }
  int get getNotificationIndex{
    return notificationList.length;
  }
}
