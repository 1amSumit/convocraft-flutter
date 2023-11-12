import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:convocraft/widgets/reciever_message_bubble.dart';
import 'package:convocraft/widgets/sender_message_bubble.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatMessagesWidget extends StatefulWidget {
  const ChatMessagesWidget({super.key, required this.recieverName});

  final String recieverName;

  @override
  State<ChatMessagesWidget> createState() => _ChatMessagesWidgetState();
}

class _ChatMessagesWidgetState extends State<ChatMessagesWidget> {
  String messageCollectionName = "";

  bool loadingMessage = false;

  void getCollection() async {
    setState(() {
      loadingMessage = true;
    });

    final senderUser = FirebaseAuth.instance.currentUser!;
    final senderUserData = await FirebaseFirestore.instance
        .collection("users")
        .doc(senderUser.uid)
        .get();

    final firstCollection = await FirebaseFirestore.instance
        .collection(
            '${senderUserData.data()!['username']}-${widget.recieverName}')
        .get();

    final secondCollection = await FirebaseFirestore.instance
        .collection(
            '${widget.recieverName}-${senderUserData.data()!['username']}')
        .get();

    if (firstCollection.docs.isEmpty && secondCollection.docs.isEmpty) {
      setState(() {
        messageCollectionName =
            '${senderUserData.data()!['username']}-${widget.recieverName}';
      });
    } else if (firstCollection.docs.isEmpty) {
      setState(() {
        messageCollectionName =
            '${widget.recieverName}-${senderUserData.data()!['username']}';
      });
    } else {
      setState(() {
        messageCollectionName =
            '${senderUserData.data()!['username']}-${widget.recieverName}';
      });
    }

    setState(() {
      loadingMessage = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getCollection();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return loadingMessage
        ? Center(
            child: CircularProgressIndicator(),
          )
        : StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection(messageCollectionName)
                .orderBy(
                  'createdAt',
                  descending: true,
                )
                .snapshots(),
            builder: (ctx, chatSnapshot) {
              if (chatSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (!chatSnapshot.hasData || chatSnapshot.data!.docs.isEmpty) {
                return const Center(
                  child: Text("No message found"),
                );
              }

              if (chatSnapshot.hasError) {
                return const Center(
                  child: Text("Something went wrong!.."),
                );
              }

              final lodedMessage = chatSnapshot.data!.docs;

              return Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: ListView.builder(
                  reverse: true,
                  padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
                  itemCount: lodedMessage.length,
                  itemBuilder: (ctx, index) {
                    return widget.recieverName ==
                            lodedMessage[index].data()["userName"]
                        ? RecieverBubble(
                            message: lodedMessage[index].data()["text"],
                            image_url: lodedMessage[index].data()["userImage"],
                          )
                        : SenderBubble(
                            message: lodedMessage[index].data()["text"]);
                  },
                ),
              );
            },
          );
  }
}
