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
    return Scaffold(
      body: Stack(
        children: [
          const Image(
            height: double.infinity,
            image: AssetImage('images/bg-3.jpg'),
            fit: BoxFit.cover,
          ),
          Positioned(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const ImageIcon(
                    AssetImage('images/chat.png'),
                    size: 100,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Conco Craft",
                    textAlign: TextAlign.left,
                    style: GoogleFonts.aboreto().copyWith(color: Colors.white),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
