import 'package:convocraft/screens/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          const Image(
            image: AssetImage("images/bg-2.jpg"),
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Positioned(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Hero(
                    tag: "heroimg",
                    child: ImageIcon(
                      AssetImage('images/chat.png'),
                      size: 160,
                      color: Color.fromARGB(255, 223, 209, 245),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      elevation: 6,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 105),
                      backgroundColor: const Color(0xff773EF2),
                    ),
                    child: Text(
                      "Log In",
                      style: GoogleFonts.roboto()
                          .copyWith(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) => const SignUpScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 6,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 100),
                      backgroundColor: const Color(0xFFA54FC9),
                    ),
                    child: Text(
                      "Sign Up",
                      style: GoogleFonts.roboto()
                          .copyWith(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
