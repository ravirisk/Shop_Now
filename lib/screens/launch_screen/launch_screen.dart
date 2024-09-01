

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_now/screens/login/login_screen.dart';
import 'package:shop_now/utils/app_logo.dart';


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

  getData() {
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const LoginScreen()), (route) => false);
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
