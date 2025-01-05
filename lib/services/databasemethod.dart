import 'package:appbanhang/model/products.dart';
import 'package:appbanhang/services/sharedpreferences/userpreferences.dart';
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
  //Đẩy danh sách sản phẩm mới lên firebase cloud firestore
  Future<DocumentReference> productMoiDetail(
      Map<String, dynamic> userInfoMap) async {
    return await FirebaseFirestore.instance
        .collection('products')
        .doc(idProduct) // Assuming idProduct is available
        .collection("sanphammoi")
        .add(userInfoMap);
  }

  //Đẩy danh sách sản phẩm nổi bật lên firebase cloud firestore
  Future<DocumentReference> productFeatureDetail(Map<String, dynamic> userInfoMap) async {
    return await FirebaseFirestore.instance
        .collection('products')
        .doc(idProduct)
        .collection("sanphamnoibat")
        .add(userInfoMap);
  }

  //Đẩy danh sách sản phẩm lên firebase cloud firestore
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

  Future<void> addOrder(List<Products> products, double totalPrice, int quantitys) async {
    final uid = await UserPreferences.getUid();
    try {

      // Tạo một tài liệu mới trong collection "orders"
      DocumentReference orderRef = await FirebaseFirestore.instance
          .collection('orders')
          .add({
        'userId': uid,
        'totalAmount': totalPrice,// Tính tổng tiền
        'soluongdadat': quantitys,// số lượng đã đặt tất cả sản phẩm
        'createdAt': FieldValue.serverTimestamp(),
        'status': 'pending',
        'products': [],// Khởi tạo mảng products
        'thanhtoan':''
      });
      // id tự sinh ra khi tạo cơ sở dữ liệu
      String idCart = orderRef.id;
      orderRef.update({'idCart': idCart});


      // Tạo danh sách các phần tử cần thêm vào mảng products
      List<Map<String, dynamic>> productsData = products.map((product) => {
        'productId': product.idProduct,
        'productName': product.name,
        'productImage': product.image,
        'productCategory': product.category,
        'productDescription': product.description,
        'productPrice': product.price,
      }).toList();
      // Thêm tất cả các phần tử vào mảng products một lần
      await orderRef.update({
        'products': FieldValue.arrayUnion(productsData)
      });
      print('Đơn hàng đã thanh toán thành công');
    } catch (e) {
      print('Lỗi khi thanh toán đơn hàng: $e');
    }
  }

  //cây lưu trữ giá trị màu, size, và sản phẩm
  Future<void> addColorSizeProduct(Products products, String size, String color, categoryRequiresSizeColor ) async {
    final uid = await UserPreferences.getUid();
    try {
      DocumentReference variantRef = await FirebaseFirestore.instance
          .collection('colorsize').add({
        'uidUser': uid,
        'size': size,
        'color': color,
        'categoryRequiresSizeColor':categoryRequiresSizeColor,
        'productId': products.idProduct,
        'productName': products.name,
        'productPrice': products.price,

      });
      String idVariant = variantRef.id;
      variantRef.update({'id': idVariant});

      print('Đơn hàng đã được thêm thành công');
      // id tự sinh ra khi tạo cơ sở dữ liệu

    }
    catch (e) {
      print('Lỗi khi thêm đơn hàng: $e');
    }
  }
}
