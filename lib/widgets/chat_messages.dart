import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatMessagesWidget extends StatelessWidget {
  const ChatMessagesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("jjh-kk")
          .orderBy(
            'createdAt',
            descending: false,
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

        return ListView.builder(
            itemCount: lodedMessage.length,
            itemBuilder: (ctx, index) {
              return Text(lodedMessage[index].data()["text"]);
            });
      },
    );
  }
}
