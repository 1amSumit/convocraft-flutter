import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.name});
  final String name;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  void makeCall() async {
    const number = "8051950952";
    final res = await FlutterPhoneDirectCaller.callNumber(number);
    print(res);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        title: Center(
          child: Text(widget.name),
        ),
        actions: [
          IconButton(
            onPressed: makeCall,
            icon: const Padding(
                padding: EdgeInsets.only(right: 30), child: Icon(Icons.phone)),
          ),
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            icon: const Icon(
              Icons.exit_to_app,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                ),
              ),
            ),
            Expanded(child: Container()),
          ],
        ),
      ),
    );
  }
}
