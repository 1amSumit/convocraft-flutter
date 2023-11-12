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
  List usersData = [];
  void fetchData() async {
    final usersDatas =
        await FirebaseFirestore.instance.collection("users").get();

    final data = usersDatas.docs.map((documnet) {
      return documnet.data();
    }).toList();

    setState(() {
      usersData = data;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
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
                child: ListView.separated(
                  separatorBuilder: (context, index) => const SizedBox(
                    width: 12,
                  ),
                  scrollDirection: Axis.horizontal,
                  itemCount: usersData.length,
                  itemBuilder: (context, index) {
                    return StatusWidget(
                        name: usersData[index]['username'],
                        imagePath: usersData[index]['image_url']);
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
                  child: ListView.builder(
                    itemCount: usersData.length,
                    itemBuilder: (context, index) {
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
                                    name: usersData[index]['username'],
                                  );
                                },
                              ),
                            );
                          },
                          title: Text(
                            usersData[index]['username'],
                            style: GoogleFonts.comfortaa().copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: const Text("subtite text"),
                          leading: ProfilePicWidget(
                              imagePath: usersData[index]['image_url']),
                        ),
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
