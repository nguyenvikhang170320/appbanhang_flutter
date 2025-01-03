import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  //đẩy dữ liệu users lên firebase cloud firestore
  Future addUserDetail(Map<String, dynamic> userInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .set(userInfoMap);
  }

  String idProduct = "ZaVWCFmxoVVRyj51jaRC";
  //Đẩy sản phẩm mới lên firebase cloud firestore
  Future<DocumentReference> productMoiDetail(
      Map<String, dynamic> userInfoMap) async {
    return await FirebaseFirestore.instance
        .collection('products')
        .doc(idProduct) // Assuming idProduct is available
        .collection("sanphammoi")
        .add(userInfoMap);
  }

  //Đẩy sản phẩm nổi bật lên firebase cloud firestore
  Future<DocumentReference> productFeatureDetail(Map<String, dynamic> userInfoMap) async {
    return await FirebaseFirestore.instance
        .collection('products')
        .doc(idProduct)
        .collection("sanphamnoibat")
        .add(userInfoMap);
  }

  //Đẩy tất cả sản phẩm lên firebase cloud firestore
  Future<DocumentReference> productDetail(Map<String, dynamic> userInfoMap) async {
    return await FirebaseFirestore.instance
        .collection('products')
        .doc(idProduct)
        .collection("sanpham")
        .add(userInfoMap);
  }

  //đẩy danh mục lên cơ sở dữ liệu
  Future categoryDetail(Map<String, dynamic> userInfoMap) async {
    return await FirebaseFirestore.instance
        .collection("categorys")
        .doc("ZaVWCFmxoVVRyj51jaRC")
        .collection("danhmuc")
        .add(userInfoMap);
  }

  //đẩy dữ liệu sản phẩm khi người dùng bấm thêm lên firebase cloud firestore
  Future addProductDetail(
      Map<String, dynamic> userInfoMap, String userId) async {
    return await FirebaseFirestore.instance
        .collection("sanpham")
        .doc("ZaVWCFmxoVVRyj51jaRC")
        .set(userInfoMap);
  }
//   Future addProductDetail(Map<String, dynamic> userInfoMap, String id) async {
//     return await FirebaseFirestore.instance.collection('giohang').doc(userId).set({
//       'products': products
// })};

  //lấy tất cả sản phẩm nổi bật
  Future<Stream<QuerySnapshot>> getProductFeatureItem() async {
    // Replace with your actual logic to fetch product stream from Firebase
    return FirebaseFirestore.instance
        .collection("products")
        .doc("ZaVWCFmxoVVRyj51jaRC")
        .collection("sanphamnoibat")
        .snapshots();
  }

  //lấy tất cả sản phẩm mới
  Future<Stream<QuerySnapshot>> getProductMoiItem() async {
    return FirebaseFirestore.instance
        .collection("products")
        .doc("ZaVWCFmxoVVRyj51jaRC")
        .collection("sanphammoi")
        .snapshots();
  }

  //lấy tất cả sản phẩm
  Future<Stream<QuerySnapshot>> getProductItem() async {
    return FirebaseFirestore.instance
        .collection("products")
        .doc("ZaVWCFmxoVVRyj51jaRC")
        .collection("sanpham")
        .snapshots();
  }

  //lấy tất cả danh mục
  Future<Stream<QuerySnapshot>> getCategoryItem() async {
    return FirebaseFirestore.instance
        .collection("categorys")
        .doc("ZaVWCFmxoVVRyj51jaRC")
        .collection("danhmuc")
        .snapshots();
  }

  // lấy sản phẩm theo danh mục
  Future<Stream<QuerySnapshot>> getProductCategoryItem(String category) async {
    // Replace with your actual logic to fetch product stream from Firebase
    return FirebaseFirestore.instance
        .collection("products")
        .doc("ZaVWCFmxoVVRyj51jaRC")
        .collection("sanpham")
        .where('Category', isEqualTo: category)
        .snapshots();
  }

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
