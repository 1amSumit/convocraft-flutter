import "package:uuid/uuid.dart";
import "dart:io";

const uuid = Uuid();

class User {
  User({
    required this.name,
    required this.email,
    required this.password,
    required this.image,
    required this.createdAt,
    String? id,
  }) : id = id ?? uuid.v4();

  final String id;
  final String name;
  final String email;
  final String password;
  final File image;
  final DateTime createdAt;
}
