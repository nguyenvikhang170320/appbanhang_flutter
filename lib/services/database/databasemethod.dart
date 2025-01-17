import 'package:appbanhang/model/category.dart';
import 'package:appbanhang/model/products.dart';
import 'package:appbanhang/services/sharedpreferences/userpreferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:random_string/random_string.dart';

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
  Future<DocumentReference> productFeatureDetail(
      Map<String, dynamic> userInfoMap) async {
    return await FirebaseFirestore.instance
        .collection('products')
        .doc(idProduct)
        .collection("sanphamnoibat")
        .add(userInfoMap);
  }

  //Đẩy danh sách sản phẩm lên firebase cloud firestore
  Future<DocumentReference> productDetail(
      Map<String, dynamic> userInfoMap) async {
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
  //tạo hóa đơn
  Future<DocumentReference> addOrder(
      List<Products> products, double totalPrice, int quantitys) async {
    final uid = await UserPreferences.getUid();
    try {
      String maHD = randomAlphaNumeric(5);

      // Tạo một tài liệu mới trong collection "orders"
      DocumentReference orderRef = await FirebaseFirestore.instance
          .collection("orders")
          .doc("hoadon")
          .collection(uid!)
          .add({
        'userId': uid,
        'totalAmount': totalPrice,
        'soluongdadat': quantitys,
        'createdAt': FieldValue.serverTimestamp(),
        'updateAt': Timestamp.now(), // dùng admin khi mình chỉnh sửa status
        'status': "Đã thanh toán",
        'maHD': maHD,
      });
      // id tự sinh ra khi tạo cơ sở dữ liệu
      String idCart = orderRef.id;
      orderRef.update({'idHD': idCart});
      // Chuẩn bị dữ liệu cho mảng products
      List<Map<String, dynamic>> productsData = products.map((product) => {
        'productId': product.idProduct,
        'productName': product.name,
        'productImage': product.image,
        'productCategory': product.category,
        'productDescription': product.description,
        'productPrice': product.price,
      }).toList();

      // Cập nhật trường products
      await orderRef.update({'products': FieldValue.arrayUnion(productsData)});

      return orderRef;
    } catch (e) {
      print('Lỗi khi thanh toán đơn hàng: $e');
      rethrow;
    }
  }
  //load hóa đơn theo người dùng
  Future<Stream<QuerySnapshot>> getHoaDonStream() async {
    final uid = await UserPreferences.getUid();
    return FirebaseFirestore.instance
        .collection("orders")
        .doc("hoadon")
        .collection(uid!)
        .snapshots();
  }


  //load tất cả hóa đơn
  Future<Stream<QuerySnapshot>> getAllHoaDonStream() async {
    return FirebaseFirestore.instance
        .collection("orders")
        .snapshots();
  }

  //cây lưu trữ giá trị màu, size, và thông tin sản phẩm
  Future<void> addColorSizeProduct(Products products, String size, String color,
      categoryRequiresSizeColor) async {
    final uid = await UserPreferences.getUid();
    try {
      DocumentReference variantRef =
          await FirebaseFirestore.instance.collection('colorsize').add({
        'uidUser': uid,
        'size': size,
        'color': color,
        'categoryRequiresSizeColor': categoryRequiresSizeColor,
        'timestamp': Timestamp.now(),
        'productId': products.idProduct,
        'productName': products.name,
        'productPrice': products.price,
      });
      String idVariant = variantRef.id;
      variantRef.update({'id': idVariant});

      print('Đơn hàng đã được thêm thành công');
      // id tự sinh ra khi tạo cơ sở dữ liệu
    } catch (e) {
      print('Lỗi khi thêm đơn hàng: $e');
    }
  }

  // Giả sử bạn đã có một hàm để fetch dữ liệu danh mục từ Firestore
  Future<List<Category>> fetchCategories() async {
    print("fetchCategories");
    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('categorys')
        .doc("ZaVWCFmxoVVRyj51jaRC")
        .collection("danhmuc")
        .get();

    return querySnapshot.docs
        .map((doc) => Category.fromFirestore(doc))
        .toList();
  }

  //Giả sử bạn đã có một hàm để fetch dữ liệu sản phẩm từ Firestore
  Future<List<Products>> fetchProducts() async {
    print("fetchProducts");
    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('products')
        .doc("ZaVWCFmxoVVRyj51jaRC")
        .collection("sanpham")
        .get();

    return querySnapshot.docs
        .map((doc) => Products.fromFirestore(doc))
        .toList();
  }

  //thẻ ngân hàng
  // Future<void> UpdateUserwallet(String id, String amount) async {
  //   final idUser = await UserPreferences.getUid();
  //   try {
  //     DocumentReference userWallet =
  //     await FirebaseFirestore.instance.collection('wallets').add({
  //       'uidUser': idUser,
  //       'amount': amount,
  //     });
  //     String idCart = userWallet.id;
  //     userWallet.update({'id': idCart});
  //
  //     print('Thêm thanh toán ngân hàng thành công');
  //     // id tự sinh ra khi tạo cơ sở dữ liệu
  //   } catch (e) {
  //     print('Lỗi khi thêm thanh toán ngân hàng: $e');
  //   }
  //
  // }
}
