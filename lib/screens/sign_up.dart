// import 'package:convocraft/screens/All_user_screen.dart';
import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:convocraft/widgets/avatar_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import "package:firebase_auth/firebase_auth.dart";
// import "package:firebase_storage/firebase_storage.dart";

// final _firebase = FirebaseAuth.instance;

import "package:flutter_riverpod/flutter_riverpod.dart";

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  bool isLogin = true;
  String enteredname = "";
  String enteredEmail = "";
  String enteredPassword = "";
  File? imageTaken;
  bool isUploading = false;

  final _formKey = GlobalKey<FormState>();

  void getImage(File image) {
    setState(() {
      imageTaken = image;
    });
  }

  void submit() {
    final isValidated = _formKey.currentState!.validate();

    if (!isValidated) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome to",
                style: GoogleFonts.roboto().copyWith(
                  fontSize: 30,
                  color: const Color.fromARGB(255, 54, 5, 111),
                ),
              ),
              const SizedBox(
                height: 3,
              ),
              Text(
                "Convo Craft",
                style: GoogleFonts.rubik().copyWith(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 54, 5, 111),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                "Enter the following details",
                style: GoogleFonts.ubuntu().copyWith(
                    fontWeight: FontWeight.w100,
                    fontSize: 14,
                    color: Colors.grey.shade500),
              ),
              const SizedBox(
                height: 2,
              ),
              Text(
                "and get connected...",
                style: GoogleFonts.ubuntu().copyWith(
                    fontWeight: FontWeight.w100,
                    fontSize: 14,
                    color: Colors.grey.shade500),
              ),
              const SizedBox(
                height: 80,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (!isLogin) AvatarWidget(sendImage: getImage),
                    const SizedBox(
                      height: 30,
                    ),
                    Form(
                      key: _formKey,
                      child: FormField(
                        builder: (context) {
                          return Column(
                            children: [
                              if (!isLogin)
                                TextFormField(
                                  decoration: const InputDecoration(
                                    label: Text("Enter your Name"),
                                  ),
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        value.length > 50 ||
                                        value.length <= 1) {
                                      return "Name must be 1 and 50 characters.";
                                    }
                                    return null;
                                  },
                                  onSaved: (name) {
                                    enteredname = name!;
                                  },
                                ),
                              TextFormField(
                                decoration: const InputDecoration(
                                  label: Text("Enter your Email"),
                                ),
                                autocorrect: false,
                                textCapitalization: TextCapitalization.none,
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      !value.contains("@")) {
                                    return "Please Enter a valid Email address.";
                                  }
                                  return null;
                                },
                                onSaved: (email) {
                                  enteredEmail = email!;
                                },
                              ),
                              TextFormField(
                                decoration: const InputDecoration(
                                  label: Text("Enter your Password"),
                                ),
                                obscureText: true,
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      value.length > 50 ||
                                      value.length < 8) {
                                    return "Password must be 8 characters.";
                                  }
                                  return null;
                                },
                                onSaved: (password) {
                                  enteredPassword = password!;
                                },
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    if (isUploading) const CircularProgressIndicator(),
                    if (!isUploading)
                      ElevatedButton.icon(
                        onPressed: submit,
                        icon: const Icon(
                          Icons.arrow_right_alt_sharp,
                          size: 24,
                        ),
                        label: Text(
                          isLogin ? "Log In" : "Sign up",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        style: ElevatedButton.styleFrom(
                          elevation: 6,
                          shadowColor: Colors.purple,
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 30),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(30),
                            ),
                          ),
                          backgroundColor:
                              const Color.fromARGB(255, 139, 70, 244),
                        ),
                      ),
                    const SizedBox(
                      height: 12,
                    ),
                    if (!isUploading)
                      TextButton(
                        onPressed: () {
                          setState(() {
                            isLogin = !isLogin;
                          });
                        },
                        child: Text(isLogin
                            ? "Create an Account"
                            : "Already have an Account"),
                      ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}



// void submit() async {
//     if (_formKey.currentState!.validate()) {
//       _formKey.currentState!.save();

//       try {
//         setState(() {
//           isUploading = true;
//         });
//         if (isLogin) {
//           final userCredential = await _firebase.signInWithEmailAndPassword(
//               email: enteredEmail, password: enteredPassword);
//           print(userCredential);
//         } else {
//           final userCredintials =
//               await _firebase.createUserWithEmailAndPassword(
//             email: enteredEmail,
//             password: enteredPassword,
//           );

//           final storageRef = FirebaseStorage.instance
//               .ref()
//               .child("user_imges")
//               .child('${userCredintials.user!.uid}.jpg');

//           await storageRef.putFile(imageTaken!);
//           final imageUrl = await storageRef.getDownloadURL();

//           await FirebaseFirestore.instance
//               .collection('users')
//               .doc(userCredintials.user!.uid)
//               .set({
//             'username': enteredname,
//             'email': enteredEmail,
//             'image_url': imageUrl,
//             "createdAt": Timestamp.now()
//           });
//         }
//         setState(() {
//           isUploading = false;
//         });
//       } on FirebaseAuthException catch (error) {
//         print("error hai bhaii");
//         if (error.code == "email-already-in-use") {
//           //...
//         }
//         ScaffoldMessenger.of(context).clearSnackBars();
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(error.message ?? "Authentication Failed"),
//           ),
//         );
//         setState(() {
//           isUploading = false;
//         });
//       }
//     }
//   }