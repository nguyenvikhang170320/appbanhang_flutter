import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  final String uid;
  final String name;
  final String email;
  final String phone;
  final String image;
  final String accountstatus;
  final String isMale;
  final String address;

  Users(
      {required this.uid,
      required this.name,
      required this.image,
      required this.email,
      required this.phone,
      required this.accountstatus,
      required this.isMale,
      required this.address});
}
