import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RecieverBubble extends StatelessWidget {
  const RecieverBubble(
      {super.key, required this.message, required this.image_url});
  final String message;
  final image_url;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(image_url),
            ),
            const SizedBox(
              width: 6,
            ),
            Container(
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.only(top: 10, bottom: 2),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(5),
                  bottomRight: Radius.circular(5),
                ),
              ),
              child: Text(
                message,
                style: GoogleFonts.delius().copyWith(color: Colors.black),
              ),
            ),
          ],
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
