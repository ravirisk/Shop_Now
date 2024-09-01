import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_now/repository/auth/auth_repo.dart';

import 'auth_state.dart';

final authProvider =
StateNotifierProvider<AuthNotifier, AuthState>(
        (ref) => AuthNotifier());

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(const AuthState()) {
    load();
  }

  load() async {
  }




}
