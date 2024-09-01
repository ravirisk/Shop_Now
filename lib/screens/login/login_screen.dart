import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_now/repository/auth/auth_repo.dart';
import 'package:shop_now/screens/home/home_screen.dart';
import 'package:shop_now/screens/signUp/signUp_screen.dart';
import 'package:shop_now/utils/app_color.dart';
import 'package:shop_now/utils/app_logo.dart';

import '../../utils/custom_model_bottom_sheet.dart';
import '../../utils/text_builder.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  Future<String?> login() async {
    if (_formKey.currentState?.validate() == true) {
      final error = await AuthRepo().loginWithEmail(
          email: _emailController.text, password: _passwordController.text);
      return error;
    } else {

    }

    return 'Validate Error';
  }

  @override
  Widget build(BuildContext context) {
    // total height and width of screen
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              const AppLogo(),
              const SizedBox(height: 50),
              Form(
                  key: _formKey,
                  child: Column(
                      children: [
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      style: GoogleFonts.poppins(color: Colors.black),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.email,
                          size: 20,
                          color: Colors.black,
                        ),
                        labelText: 'Email',
                        hintText: 'Enter your email id',
                        border: _border(),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                      controller: _passwordController,
                      keyboardType: TextInputType.emailAddress,
                      style: GoogleFonts.poppins(color: Colors.black),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.lock,
                          size: 20,
                          color: Colors.black,
                        ),
                        labelText: 'Password',
                        hintText: 'Password',
                        border: _border(),
                      ),
                    )
                  ])),
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () {},
                  child: const TextBuilder(
                    text: 'Forgot Password',
                    fontSize: 16,
                    color: Colors.blue,
                  ),
                ),
              ),
              const SizedBox(height: 30.0),
              Center(
                child: MaterialButton(
                  height: 60,
                  color: AppColors.kBlue,
                  minWidth: size.width * 0.8,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  onPressed: () async {
                   final error = await login();
                   if (error == null) {
                     Navigator.push(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
                   } else {
                     ToastMessage().showToast(context, error);
                   }
                    //
                  },
                  child: const TextBuilder(
                    text: 'Login',
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const TextBuilder(
                    text: "Don't have an account? ",
                    color: Colors.black,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const SignupScreen()));
                    },
                    child: const TextBuilder(
                      text: 'Sign Up',
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputBorder _border() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Colors.black),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
