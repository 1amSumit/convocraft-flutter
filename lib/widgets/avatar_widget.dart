import 'package:flutter/material.dart';
import "package:image_picker/image_picker.dart";

import "dart:io";

class AvatarWidget extends StatefulWidget {
  const AvatarWidget({super.key, required this.sendImage});

  final void Function(File) sendImage;

  @override
  State<AvatarWidget> createState() => _AvatarWidgetState();
}

class _AvatarWidgetState extends State<AvatarWidget> {
  File? imagePic;

  void captureImage() async {
    final imagePicker = ImagePicker();
    final imageCaptured = await imagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 300,
    );
    if (imageCaptured == null) {
      return;
    }
    setState(() {
      imagePic = File(imageCaptured.path);
    });
  }

  void uploadFromGallery() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 300,
    );
    if (pickedImage == null) {
      return;
    }
    setState(() {
      imagePic = File(pickedImage.path);
    });

    widget.sendImage(imagePic!);
  }

  @override
  Widget build(BuildContext context) {
    Widget avatarContent = GestureDetector(
      onTap: captureImage,
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color.fromARGB(255, 139, 70, 244)),
        child: const Center(
          child: Icon(Icons.add_a_photo_outlined),
        ),
      ),
    );

    if (imagePic != null) {
      avatarContent = GestureDetector(
        onTap: captureImage,
        child: SizedBox(
          width: 100,
          height: 100,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(60),
            child: Image.file(
              imagePic!,
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    }

    return Row(
      children: [
        avatarContent,
        const SizedBox(
          width: 30,
        ),
        Column(
          children: [
            IconButton(
              onPressed: uploadFromGallery,
              icon: const Icon(
                Icons.add_photo_alternate_outlined,
                size: 40,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            const Text("upload from gallery"),
          ],
        )
      ],
    );
  }
}
