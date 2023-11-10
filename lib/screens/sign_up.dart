import 'package:convocraft/screens/register_screen.dart';
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
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage("images/bg-1.jpg"),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Form(
                      child: FormField(
                        builder: (context) {
                          return Column(
                            children: [
                              TextFormField(
                                decoration: const InputDecoration(
                                  label: Text("Enter your Name"),
                                ),
                              ),
                              TextFormField(
                                decoration: const InputDecoration(
                                  label: Text("Enter your Email"),
                                ),
                              ),
                              TextFormField(
                                decoration: const InputDecoration(
                                  label: Text("Enter your Password"),
                                ),
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
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (ctx) => const RegisterScreen(),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.arrow_right_alt_sharp,
                        size: 24,
                      ),
                      label: const Text(
                        "Connect",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      style: ElevatedButton.styleFrom(
                        elevation: 6,
                        shadowColor: Colors.green,
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 30),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          ),
                        ),
                        backgroundColor: Color.fromARGB(255, 139, 70, 244),
                      ),
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
