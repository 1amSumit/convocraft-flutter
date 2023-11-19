import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:convocraft/screens/chat_screen.dart';
import 'package:convocraft/widgets/profile_pic.dart';
import 'package:convocraft/widgets/status_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AllUserScreen extends StatefulWidget {
  const AllUserScreen({super.key});

  @override
  State<AllUserScreen> createState() => _AllUserScreenState();
}

class _AllUserScreenState extends State<AllUserScreen> {
  var currentUser;

  void getCurrentUserName() async {
    final user = FirebaseAuth.instance.currentUser!;
    final userData = await FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .get();

    final userName = userData.data()!['username'];

    setState(() {
      currentUser = userName;
    });
  }

  @override
  void initState() {
    super.initState();
    getCurrentUserName();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 30, left: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Chat",
                    style: GoogleFonts.comfortaa().copyWith(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                    },
                    icon: const Icon(
                      Icons.exit_to_app,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, bottom: 30),
              child: Container(
                height: 100,
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("users")
                      .orderBy("createdAt", descending: false)
                      .snapshots(),
                  builder: (ctx, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return const Center(
                        child: Text("No message found"),
                      );
                    }

                    if (snapshot.hasError) {
                      return const Center(
                        child: Text("Something went wrong!.."),
                      );
                    }
                    final usersData = snapshot.data!.docs;
                    return ListView.separated(
                      separatorBuilder: (context, index) => const SizedBox(
                        width: 12,
                      ),
                      scrollDirection: Axis.horizontal,
                      itemCount: usersData.length,
                      itemBuilder: (context, index) {
                        return currentUser != usersData[index]['username']
                            ? StatusWidget(
                                name: usersData[index]['username'],
                                imagePath: usersData[index]['image_url'])
                            : null;
                      },
                    );
                  },
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("users")
                        .orderBy("createdAt", descending: true)
                        .snapshots(),
                    builder: (ctx, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return const Center(
                          child: Text("No message found"),
                        );
                      }

                      if (snapshot.hasError) {
                        return const Center(
                          child: Text("Something went wrong!.."),
                        );
                      }
                      final usersData = snapshot.data!.docs;
                      return ListView.builder(
                        itemCount: usersData.length,
                        itemBuilder: (context, index) {
                          return currentUser != usersData[index]['username']
                              ? UserWidget(usersData: usersData[index])
                              : null;
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UserWidget extends StatelessWidget {
  const UserWidget({
    super.key,
    required this.usersData,
  });

  final usersData;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1, color: Colors.grey),
        ),
      ),
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (ctx) {
                return ChatScreen(
                  reciever: usersData['username'],
                );
              },
            ),
          );
        },
        title: Text(
          usersData['username'],
          style: GoogleFonts.comfortaa().copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: const Text("subtite text"),
        leading: ProfilePicWidget(imagePath: usersData['image_url']),
      ),
    );
  }
}
