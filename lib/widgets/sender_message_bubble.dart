import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SenderBubble extends StatelessWidget {
  const SenderBubble({super.key, required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          padding: const EdgeInsets.all(15),
          margin: const EdgeInsets.only(top: 10, bottom: 2),
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 254, 167, 167),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(5),
              bottomLeft: Radius.circular(5),
            ),
          ),
          child: Text(
            message,
            style: GoogleFonts.delius().copyWith(color: Colors.white),
          ),
        ),
        Text(
          "18:23",
          style: GoogleFonts.delius().copyWith(
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
