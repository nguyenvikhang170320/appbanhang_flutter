import 'package:appbanhang/model/seller.dart';
import 'package:appbanhang/model/users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class SellerProvider extends ChangeNotifier {
  List<Seller> userModelList = [];
  List<Seller> get items => userModelList;
  Future<void> getUserData() async {
    // Get current user (optional, if needed)
    User? currentUser = FirebaseAuth.instance.currentUser;
    // Fetch data from Firestore (assuming a collection named 'users')
    QuerySnapshot<Map<String, dynamic>> userSnapShot =
    await FirebaseFirestore.instance.collection('users').get();

    // Process each document in the snapshot
    userSnapShot.docs.forEach((doc) {
      // Extract data from the document
      if (currentUser?.uid == doc.data()['uid']) {
        Map<String, dynamic> userData = doc.data();
        // Create a Users object (assuming appropriate constructor)
        Seller seller = Seller(
            uid: userData['uid'],
            name: userData['name'],
            shopname: userData['shopname'],
            image: userData['image'],
            email: userData['email'],
            phone: userData['phone'],
            isMale: userData['isMale'],
            accountstatus: userData['accountstatus'],
            address: userData['address'],
            role: userData['role']);

        // Add the user to the internal list
        userModelList.add(seller);
      }
    });
    // Notify listeners about changes
    notifyListeners();
  }
  List<Seller> get getUserList{
    return userModelList;
  }

  void signOut() {
    userModelList.clear();
    print(userModelList);
    notifyListeners();
  }
  // Additional methods to get specific user data (optional)
  String getNameData() {
    if (userModelList.isEmpty) {
      return ""; // Handle empty list case
    }
    return  userModelList.fold(
        "", (total, item) => item.name); // Get all names
  }
  String getShopNameData() {
    if (userModelList.isEmpty) {
      return ""; // Handle empty list case
    }
    return  userModelList.fold(
        "", (total, item) => item.shopname); // Get all names
  }
  String getImageData() {
    if (userModelList.isEmpty) {
      return ""; // Handle empty list case
    }
    return  userModelList.fold(
        "", (total, item) => item.image);
  }

  String getEmailData() {
    if (userModelList.isEmpty) {
      return ""; // Handle empty list case
    }
    return userModelList.first.email; // Get all emails
  }
  String getPhoneData() {
    if (userModelList.isEmpty) {
      return ""; // Handle empty list case
    }
    return  userModelList.fold(
        "", (total, item) => item.phone);  // Get all emails
  }
  String getAddressData() {
    if (userModelList.isEmpty) {
      return ""; // Handle empty list case
    }
    return  userModelList.fold(
        "", (total, item) => item.address);  // Get all names
  }
  String getIsMaleData () {
    if (userModelList.isEmpty) {
      return ""; // Handle empty list case
    }
    return userModelList.first.isMale; // Get all emails
  }
  String getAccountStatusData () {
    if (userModelList.isEmpty) {
      return ""; // Handle empty list case
    }
    return userModelList.first.accountstatus;// Get all emails
  }
  String getUidData () {
    if (userModelList.isEmpty) {
      return ""; // Handle empty list case
    }
    return  userModelList.fold(
        "", (total, item) => item.uid); ;// Get all emails
  }
}