import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  //cây users
  Future addUserDetail(Map<String, dynamic> userInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .set(userInfoMap);
  }

  String idProduct = "ZaVWCFmxoVVRyj51jaRC";
  //cây product
  Future productDetail(Map<String, dynamic> userInfoMap, String name) async {
    return await FirebaseFirestore.instance
        .collection('products')
        .doc(idProduct)
        .collection("featureproduct")
        .doc(name)
        .set(userInfoMap);
  }

  // UpdateUserwallet(String id, String amount) async {
  //   return await FirebaseFirestore.instance
  //       .collection("users")
  //       .doc(id)
  //       .update({"Wallet": amount});
  // }

//To retrieve the string

  // Future<Stream<QuerySnapshot>> getFoodItem(String name) async {
  //   return await FirebaseFirestore.instance.collection(name).snapshots();
  // }

  // Future addFoodToCart(Map<String, dynamic> userInfoMap, String id) async {
  //   return await FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(id)
  //       .collection("Cart")
  //       .add(userInfoMap);
  // }

  // Future<Stream<QuerySnapshot>> getFoodCart(String id) async {
  //   return await FirebaseFirestore.instance
  //       .collection("users")
  //       .doc(id)
  //       .collection("Cart")
  //       .snapshots();
  // }
}
