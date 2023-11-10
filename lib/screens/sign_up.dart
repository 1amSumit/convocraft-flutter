import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  fontSize: 34,
                  color: const Color.fromARGB(255, 54, 5, 111),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Text("Convo Craft"),
            ],
          ),
        ),
      ),
    );
  }
}
