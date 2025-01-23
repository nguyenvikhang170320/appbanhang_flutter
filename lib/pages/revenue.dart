import 'package:appbanhang/pages/bottomnav.dart';
import 'package:appbanhang/services/sharedpreferences/userpreferences.dart';
import 'package:appbanhang/widgets/style/widget_support.dart';
import 'package:appbanhang/widgets/thongbao/notificationbutton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class Revenue extends StatefulWidget {
  const Revenue({super.key});

  @override
  State<Revenue> createState() => _RevenueState();
}

class _RevenueState extends State<Revenue> {

  List<String> months = ['Tháng 1', 'Tháng 2', 'Tháng 3', 'Tháng 4', 'Tháng 5',
    'Tháng 6', 'Tháng 7', 'Tháng 8', 'Tháng 9', 'Tháng 10', 'Tháng 11', 'Tháng 12'];
  Map<String, String> formattedRevenues = {}; // Map to store formatted revenue strings

  Future<void> fetchData() async {

    final uid = await UserPreferences.getUid();
    print(uid);
    Query query = FirebaseFirestore.instance
        .collection("orders")
        .doc("hoadon")
        .collection(uid!)
        .where('createdAt', isGreaterThanOrEqualTo: Timestamp.fromDate(DateTime(2025, 1, 1, 0, 0, 0, 0))) // Ensure all hours, minutes, seconds, milliseconds are included
        .where('createdAt', isLessThanOrEqualTo: Timestamp.fromDate(DateTime(2025, 12, 31, 23, 59, 59, 999)));

    QuerySnapshot snapshot = await query.get();
    print(snapshot.docs);
    // Update formatted revenues map with retrieved data
    for (var month in months) {
      double totalRevenue = calculateRevenueForMonth(month, snapshot.docs);
      final locale = 'vi_VN';
      final formatter = NumberFormat.currency(name: "đ", locale: locale);
      formatter.maximumFractionDigits = 0;
      String formattedPrice = formatter.format(totalRevenue);
      formattedRevenues[month] = formattedPrice;
      print(formattedPrice);
    }

    // Update UI
    setState(() {});
  }

  double calculateRevenueForMonth(String month, List<QueryDocumentSnapshot> documents) {
    print(20);
    double totalRevenue = 0;
    DateTime firstDayOfMonth = DateTime(2025, getMonthNumber(month), 1);
    DateTime lastDayOfMonth = DateTime(2025, getMonthNumber(month) + 1, 0);

    for (var doc in documents) {
      print(30);
      Timestamp createdAt = doc.get('createdAt') as Timestamp;
      DateTime orderDate = createdAt.toDate();

      double totalAmount = doc.get('totalAmount') as double; // Lấy tổng tiền dưới dạng double

      if (orderDate.isAfter(firstDayOfMonth) && orderDate.isBefore(lastDayOfMonth)) {
        totalRevenue += totalAmount;
        print(totalRevenue);
      }
    }

    return totalRevenue;
  }

  // Hàm hỗ trợ chuyển đổi tên tháng thành số thứ tự
  int getMonthNumber(String month) {
    switch (month) {
    case 'Tháng 1':
        return 1;
    case 'Tháng 2':
        return 2;
    case 'Tháng 3':
        return 3;
    case 'Tháng 4':
        return 4;
    case 'Tháng 5':
        return 5;
    case 'Tháng 6':
        return 6;
    case 'Tháng 7':
        return 7;
    case 'Tháng 8':
        return 8;
    case 'Tháng 9':
        return 9;
    case 'Tháng 10':
        return 10;
    case 'Tháng 11':
        return 11;
    case 'Tháng 12':
        return 12;
    }
    return -1; // Trả về -1 nếu không tìm thấy tháng
  }
  @override
  void initState() {
    super.initState();
    fetchData();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text(
          "Doanh thu",
          style: AppWidget.boldTextFeildStyle(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (ctx) => BottomNav(),
              ),
            );
          },
        ),
        actions: <Widget>[
          NotificationButton(),
        ],
      ),
      body: ListView.builder(
        itemCount: months.length,
        itemBuilder: (context, index) {
          String month = months[index];
          return ListTile(
            title: Text('$month: ${formattedRevenues[month] ?? 'Đang tải'}'),
          );
        },
      ),
    );
  }
}
