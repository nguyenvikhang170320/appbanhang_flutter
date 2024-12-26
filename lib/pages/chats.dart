import 'package:flutter/material.dart';

class Chats extends StatefulWidget {
  const Chats({super.key});

  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      margin: EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0, bottom: 20.0),
      child: Text("Tin nhắn"),
    );
  }
}
