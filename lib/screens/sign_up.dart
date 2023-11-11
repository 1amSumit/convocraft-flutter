// import 'package:convocraft/screens/All_user_screen.dart';
import 'package:convocraft/widgets/avatar_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import "package:firebase_auth/firebase_auth.dart";

final _firebase = FirebaseAuth.instance;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isLogin = true;
  String enteredname = "";
  String enteredEmail = "";
  String enteredPassword = "";
  late File imageTaken;

  final _formKey = GlobalKey<FormState>();

  void getImage(File image) {
    setState(() {
      imageTaken = image;
    });
  }

  void submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      _formKey.currentState!.reset();

      try {
        if (isLogin) {
          final userCredential = _firebase.signInWithEmailAndPassword(
              email: enteredEmail, password: enteredPassword);
        } else {
          final userCredintials =
              await _firebase.createUserWithEmailAndPassword(
                  email: enteredEmail, password: enteredPassword);
        }
      } on FirebaseAuthException catch (error) {
        if (error.code == "email-already-in-use") {
          //...
        }
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error.message ?? "Authentication Failed"),
          ),
        );
      }

      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (ctx) {
      //       return AllUserScreen();
      //     },
      //   ),
      // );
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
                    AvatarWidget(sendImage: getImage),
                    const SizedBox(
                      height: 30,
                    ),
                    Form(
                      key: _formKey,
                      child: FormField(
                        builder: (context) {
                          return Column(
                            children: [
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
