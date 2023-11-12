import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SendMessageWidget extends StatefulWidget {
  const SendMessageWidget({super.key, required this.recieverUser});

  final String recieverUser;

  @override
  State<SendMessageWidget> createState() => _SendMessageWidgetState();
}

class _SendMessageWidgetState extends State<SendMessageWidget> {
  var messageController = TextEditingController();
  String messageCollectionName = "";

  void submitMessage() async {
    final enteredMessage = messageController.text;
    if (enteredMessage.trim().isEmpty) {
      return;
    }
    FocusScope.of(context).unfocus();
    messageController.clear();
    //send to firebase

    final senderUser = FirebaseAuth.instance.currentUser!;
    final senderUserData = await FirebaseFirestore.instance
        .collection("users")
        .doc(senderUser.uid)
        .get();

    final firstCollection = await FirebaseFirestore.instance
        .collection(
            '${senderUserData.data()!['username']}-${widget.recieverUser}')
        .get();

    final secondCollection = await FirebaseFirestore.instance
        .collection(
            '${widget.recieverUser}-${senderUserData.data()!['username']}')
        .get();

    if (firstCollection.docs.isEmpty) {
      if (secondCollection.docs.isEmpty) {
        messageCollectionName =
            '${senderUserData.data()!['username']}-${widget.recieverUser}';
      }
    } else if (firstCollection.docs.isNotEmpty) {
      if (secondCollection.docs.isEmpty) {
        messageCollectionName =
            '${senderUserData.data()!['username']}-${widget.recieverUser}';
      }
    } else {
      messageCollectionName =
          '${widget.recieverUser}-${senderUserData.data()!['username']}';
    }

    FirebaseFirestore.instance.collection(messageCollectionName).add({
      'text': enteredMessage,
      'createdAt': Timestamp.now(),
      'userId': senderUser.uid,
      'userName': senderUserData.data()!['username'],
      'userImage': senderUserData.data()!['image_url'],
    });
  }

  @override
  void dispose() {
    super.dispose();
    messageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 10),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: TextField(
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
              controller: messageController,
              textCapitalization: TextCapitalization.sentences,
              autocorrect: true,
              enableSuggestions: true,
              decoration: InputDecoration(
                hintText: "send Message",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                filled: true,
                fillColor: Colors.grey.shade200,
                suffixIcon: const Icon(
                  Icons.attachment,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: submitMessage,
            icon: Icon(
              Icons.send,
              color: Colors.grey.shade200,
            ),
          ),
        ],
      ),
    );
  }
}
