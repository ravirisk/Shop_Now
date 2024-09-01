
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_now/repository/auth/auth_repo.dart';
import 'package:shop_now/screens/login/login_screen.dart';
import 'package:shop_now/utils/app_color.dart';
import 'package:shop_now/utils/app_logo.dart';

import '../../utils/custom_model_bottom_sheet.dart';
import '../../utils/text_builder.dart';
import '../home/home_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  SignupScreenState createState() => SignupScreenState();
}

class SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context,) {
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
                  child: Column(children: [
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                      controller: _nameController,
                      keyboardType: TextInputType.name,
                      style: GoogleFonts.poppins(color: Colors.black),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.person,
                          size: 20,
                          color: Colors.black,
                        ),
                        labelText: 'Full Name',
                        hintText: 'Enter your name',
                        border: _border(),
                      ),
                    ),
                    const SizedBox(height: 20),
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
                    ),
                    const SizedBox(height: 20,),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your password';
                        }
                        return null;
                      },
                      controller: _confirmPasswordController,
                      keyboardType: TextInputType.emailAddress,
                      style: GoogleFonts.poppins(color: Colors.black),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.lock,
                          size: 20,
                          color: Colors.black,
                        ),
                        labelText: 'Password',
                        hintText: ' Confirm Password',
                        border: _border(),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ])),
              Center(
                child: MaterialButton(
                  height: 60,
                  color: AppColors.kBlue,
                  minWidth: size.width * 0.8,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  onPressed: () async {
                    final error = await signUp();
                    if (error == null) {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
                    } else {
                      ToastMessage().showToast(context, error);
                    }
                    //Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const LoginScreen()), (route) => false);
                  },
                  child: const TextBuilder(
                    text: 'Sign Up',
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
                    text: "Have have an account? ",
                    color: Colors.black,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginScreen()));
                    },
                    child: const TextBuilder(
                      text: 'Login',
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
    _nameController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }


  Future<String?> signUp() async {
    if (_formKey.currentState?.validate() == true) {
      final error = await AuthRepo().signUpWithEmail(
          email: _emailController.text, password: _passwordController.text, name: _nameController.text,);
      return error;
    }

    return 'Validate Error';
  }

}


