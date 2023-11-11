import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class StatusWidget extends StatelessWidget {
  const StatusWidget({
    super.key,
    required this.name,
    required this.imagePath,
  });

  final String imagePath;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: Image.network(
            imagePath,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        Text(
          name,
          style: GoogleFonts.comfortaa()
              .copyWith(color: Colors.white, fontSize: 12),
        ),
      ],
    );
  }
}
