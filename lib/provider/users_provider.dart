import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:convocraft/models/user_model.dart";
import "dart:io";

class UsersProviderNotifier extends StateNotifier<List<User>> {
  UsersProviderNotifier() : super([]);

  void addUser(
    String name,
    String email,
    String password,
    File image,
    DateTime createdAt,
  ) {
    final newUser = User(
      name: name,
      email: email,
      password: password,
      image: image,
      createdAt: createdAt,
    );

    state = [...state, newUser];
  }
}

final usersProvider =
    StateNotifierProvider<UsersProviderNotifier, List<User>>((ref) {
  return UsersProviderNotifier();
});
