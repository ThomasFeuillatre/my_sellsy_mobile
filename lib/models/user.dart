import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class User {
  final String name;
  final String email;

  User({required this.name, required this.email});
}

class UserState extends StateNotifier<User?> {
  UserState() : super(null);

  Future<void> login(String email, String password) async {
    // This mocks a login attempt with email and password
    state = await Future.delayed(
      const Duration(milliseconds: 750),
      () => User(name: "My Name", email: "My Email"),
    );
  }

  Future<void> logout() async {
    // In this example user==null iff we're logged out
    state = null; // No request is mocked here but I guess we could
  }
}

final authProvider = StateNotifierProvider<UserState, User?>((ref) {
  return UserState();
});
