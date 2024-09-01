
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_now/repository/auth/auth_repo.dart';
import 'package:shop_now/screens/home/home_screen.dart';
import 'package:shop_now/screens/login/login_screen.dart';
import 'package:shop_now/screens/signUp/signUp_screen.dart';
import 'package:shop_now/utils/configuration/firebase_config.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
 await FirebaseConfig().init();
  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final user = AuthRepo().user.email;
    return   MaterialApp(
      home: user == null ? const SignupScreen() : const HomeScreen(),
    );
  }
}


