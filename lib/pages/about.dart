import 'package:appbanhang/pages/bottomnav.dart';
import 'package:appbanhang/services/dieukhoanvachinhsachbaomat/service.dart';
import 'package:flutter/material.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Thông tin",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
            future: Service().loadAsset(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data!);
              } else if (snapshot.hasError) {
                return Text('Đã xảy ra lỗi khi đọc file');
              } else {
                // Show a loading indicator while data is being fetched
                return Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }
}
