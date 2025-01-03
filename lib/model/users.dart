import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  final String userId;
  final String name;
  final String email;
  final String password;
  final String phone;
  final String image;

  Users(
      {required this.userId,
      required this.name,
      required this.image,
      required this.email,
      required this.password,
      required this.phone});
  factory Users.fromFirestore(DocumentSnapshot doc) {
    return Users(
      userId: doc["Id"] as String,
      name: doc['Name'] as String,
      image: doc['Image'] as String,
      email: doc['Image'] as String,
      password: doc['Image'] as String,
      phone: doc['Image'] as String,
    );
  }
}
