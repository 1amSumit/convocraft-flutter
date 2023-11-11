import 'package:convocraft/screens/sign_up.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class GettingStartedScreen extends StatefulWidget {
  const GettingStartedScreen({super.key});

  @override
  State<GettingStartedScreen> createState() => _GettingStartedScreenState();
}

class _GettingStartedScreenState extends State<GettingStartedScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Image(
          height: double.infinity,
          image: AssetImage('images/bg-3.jpg'),
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              Positioned(
                bottom: 170,
                left: 90,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Hero(
                      tag: "heroimg",
                      child: ImageIcon(
                        AssetImage('images/chat.png'),
                        size: 100,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Convo Craft",
                      style: GoogleFonts.tourney().copyWith(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    const Text(
                      "Online messaging made easy",
                      style: TextStyle(
                          color: Color.fromARGB(255, 189, 187, 187),
                          fontSize: 20,
                          fontWeight: FontWeight.w100),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    const Text(
                      "Join for free",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Color.fromARGB(255, 165, 164, 164),
                        fontSize: 16,
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (ctx) => const SignUpScreen(),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.arrow_right_alt_sharp,
                        size: 24,
                      ),
                      label: const Text(
                        "Get Started",
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
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
