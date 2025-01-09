import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  final String userId;
  final String name;
  final String email;
  final String password;
  final String phone;
  final String image;
  final String accountstatus;
  final String isMale;
  final String address;

  Users(
      {required this.userId,
      required this.name,
      required this.image,
      required this.email,
      required this.password,
      required this.phone,
      required this.accountstatus,
      required this.isMale,
      required this.address});
  // factory Users.fromFirestore(DocumentSnapshot doc) {
  //   return Users(
  //     userId: doc["Id"] as String,
  //     name: doc['name'] as String,
  //     image: doc['image'] as String,
  //     email: doc['email'] as String,
  //     password: doc['password'] as String,
  //     phone: doc['phone'] as String,
  //     isMale: doc['isMale'] as bool,
  //   );
  // }
}
