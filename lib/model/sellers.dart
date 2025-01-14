import 'package:cloud_firestore/cloud_firestore.dart';

class Sellers {
  final String uid;
  final String name;
  final String email;
  final String phone;
  final String image;
  final String accountstatus;
  final String isMale;
  final String address;

  Sellers(
      {required this.uid,
        required this.name,
        required this.image,
        required this.email,
        required this.phone,
        required this.accountstatus,
        required this.isMale,
        required this.address});
  factory Sellers.fromFirestore(DocumentSnapshot doc) {
    return Sellers(
      uid: doc['uid'] as String,
      name: doc['name'] as String,
      image: doc['image'] as String,
      email: doc['email'] as String,
      phone: doc['phone'] as String,
      accountstatus: doc['accountstatus'] as String,
      isMale: doc['isMale'] as String,
      address: doc['address'] as String,
    );
  }
}
