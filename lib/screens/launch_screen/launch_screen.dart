import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_now/screens/home/home_screen.dart';
import 'package:shop_now/screens/login/login_screen.dart';
import 'package:shop_now/screens/signUp/signUp_screen.dart';
import 'package:shop_now/utils/app_logo.dart';

import '../../repository/auth/auth_repo.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  SplashState createState() => SplashState();
}

class SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2)).then((value) => getData());
  }

  getData() async {
    final loginStatus = await AuthRepo().getLoginStatus();
    if (loginStatus) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const HomeScreen()),
          (route) => false);
    } else {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const SignupScreen()),
          (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(child: AppLogo()),
      ),
    );
  }
}
