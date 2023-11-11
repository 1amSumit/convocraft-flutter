import 'package:flutter/material.dart';

class ProfilePicWidget extends StatelessWidget {
  const ProfilePicWidget({super.key, required this.imagePath});

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(60),
          child: Image.network(
            imagePath,
            width: 50, // Set your desired width
            height: 50, // Set your desired height
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}
