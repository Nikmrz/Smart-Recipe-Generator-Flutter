import 'package:flutter/material.dart';
import 'package:smart_recipe_generator_flutter/app/modules/home/views/home_view.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.controller});
  final PageController controller;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/introduction_animation/boywithsauce.png",
                width: 258,
                height: 237,
              ),
              const SizedBox(height: 18),
              const Text(
                'Log In',
                style: TextStyle(
                  color: Color(0xFF755DC1),
                  fontSize: 27,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 30),

              // Email Input Field
              SizedBox(
                height: 56,
                child: TextField(
                  controller: _emailController,
                  textAlign: TextAlign.center,
                  decoration: _inputDecoration('Email', 'Enter your email'),
                ),
              ),
              const SizedBox(height: 17),

              // Password Input Field
              SizedBox(
                height: 56,
                child: TextField(
                  controller: _passController,
                  textAlign: TextAlign.center,
                  obscureText: true,
                  decoration: _inputDecoration('Password', 'Enter your password'),
                ),
              ),
              const SizedBox(height: 25),

              // Sign In Button
              SizedBox(
                width: 329,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeView() // user back najawos vanera .pushreplacement gareko if garne vaye .push
                    ),
                  );
                },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF9F7BFF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Log In',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),

              // Sign Up Option
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Don’t have an account?',
                    style: TextStyle(
                      color: Color(0xFF837E93),
                      fontSize: 13,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 5),
                  InkWell(
                    onTap: () {
                      widget.controller.animateToPage(1,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.ease);
                    },
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        color: Color(0xFF755DC1),
                        fontSize: 13,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),

              // Forgot Password
              InkWell(
                onTap: () {
                  // TODO: Implement Forgot Password functionality
                },
                child: const Text(
                  'Forgot Password?',
                  style: TextStyle(
                    color: Color(0xFF755DC1),
                    fontSize: 13,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // OR Divider
              Row(
                children: [
                  Expanded(child: Divider(color: Color(0xFF837E93))),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      'Or log in with',
                      style: TextStyle(
                        color: Color(0xFF837E93),
                        fontSize: 13,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Expanded(child: Divider(color: Color(0xFF837E93))),
                ],
              ),
              const SizedBox(height: 15),

              // Login with Google Button
              SizedBox(
                width: 329,
                height: 56,
                child: ElevatedButton.icon(
                  onPressed: () {
                    // TODO: Implement Google Login logic
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: const BorderSide(color: Color(0xFF837E93)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  icon: Image.asset(
                    'assets/icons/google.png', // Ensure you have this image in assets
                    width: 24,
                    height: 24,
                  ),
                  label: const Text(
                    'Log in with Google',
                    style: TextStyle(
                      color: Color(0xFF393939),
                      fontSize: 15,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // Helper function for input decorations
  InputDecoration _inputDecoration(String label, String hint) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      hintStyle: const TextStyle(
        color: Color(0xFF837E93),
        fontSize: 10,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w400,
      ),
      labelStyle: const TextStyle(
        color: Color(0xFF755DC1),
        fontSize: 15,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w600,
      ),
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(
          width: 1,
          color: Color(0xFF837E93),
        ),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(
          width: 1,
          color: Color(0xFF9F7BFF),
        ),
      ),
    );
  }
}
