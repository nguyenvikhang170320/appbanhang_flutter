import 'package:appbanhang/admin/admin_login.dart';
import 'package:appbanhang/pages/homepages.dart';
import 'package:appbanhang/widgets/productmytextformfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PostProduct extends StatefulWidget {
  const PostProduct({super.key});

  @override
  State<PostProduct> createState() => _PostProductState();
}

class _PostProductState extends State<PostProduct> {
  String name = "";
  double price = 0.0;

  //text style
  final TextStyle myStyle = TextStyle(fontSize: 18);

  final GlobalKey<FormState> formState = GlobalKey<FormState>();

//style button
  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    foregroundColor: Colors.black87,
    backgroundColor: Color.fromARGB(255, 23, 240, 88),
    padding: EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
    ),
  );
  void readData() async {
    CollectionReference users =
        FirebaseFirestore.instance.collection('Category');

    // Retrieve all documents in the 'users' collection
    QuerySnapshot querySnapshot = await users.get();
    querySnapshot.docs.forEach((doc) {
      print('name: ${doc['name']}, image: ${doc['image']}');
    });

    // Retrieve a specific document
    DocumentSnapshot documentSnapshot =
        await users.doc('SkzzZFBe6wPlyKbj9EqY').get();
    print(
        'name: ${documentSnapshot['name']}, image: ${documentSnapshot['image']}');
  }

// button đặt hàng
  Widget _buildCheckOut() {
    return Container(
      margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
      child: ElevatedButton(
        style: raisedButtonStyle,
        onPressed: () {
          setState(() {});
        },
        child: Text('Thêm sản phẩm'),
      ),
    );
  }

  Widget _buildAllTextFormField() {
    return Container(
      height: 400,
      width: 400,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ProductMyTextFormField(
            name: "Tên sản phẩm",
            onChanged: (value) {
              setState(() {
                name = value!;
              });
            },
          ),
          SizedBox(
            height: 10,
          ),
          ProductMyTextFormField(
            //liên quan đến file productmytextformfield.dart
            name: "Giá",
            onChanged: (value) {
              setState(() {
                price = value! as double;
              });
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 60,
        width: 100,
        padding: EdgeInsets.only(bottom: 10),
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: _buildCheckOut(),
      ),
      appBar: AppBar(
        title: Center(
          child: Text(
            "Tạo sản phẩm",
            style: myStyle,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.notifications_none,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          SafeArea(
            child: Form(
              key: formState,
              child: Container(
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/shop1.jpg',
                      width: 300,
                      height: 150,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 500,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          _buildAllTextFormField(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
