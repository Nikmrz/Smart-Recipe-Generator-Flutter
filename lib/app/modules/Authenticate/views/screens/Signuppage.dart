import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:smart_recipe_generator_flutter/app/modules/Authenticate/views/authenticate_view.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key, required this.controller});
  final PageController controller;

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  bool _isLoading = false;
  String? _nameError;
  String? _emailError;
  String? _phoneError;
  String? _passError;

  Future<void> _signUp() async {
    setState(() {
      _nameError =
          _nameController.text.trim().isEmpty ? "Please enter your name" : null;
      _emailError =
          _emailController.text.trim().isEmpty
              ? "Please enter your email"
              : null;
      _phoneError =
          _phoneController.text.trim().isEmpty
              ? "Please enter your phone number"
              : null;
      _passError =
          _passController.text.trim().isEmpty
              ? "Please enter your password"
              : null;
    });

    if (_nameError != null ||
        _emailError != null ||
        _phoneError != null ||
        _passError != null) {
      return;
    }

    final String apiUrl = "http://127.0.0.1:4000/signup";
    final Map<String, dynamic> userData = {
      "user": {
        "name": _nameController.text.trim(),
        "email": _emailController.text.trim(),
        "password": _passController.text.trim(),
        "phone": _phoneController.text.trim(),
      },
    };

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json", "Accept": "application/json"},
        body: jsonEncode(userData),
      );

      final Map<String, dynamic> responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Sign up successful"),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AuthenticateView()),
        );
      }else{
        String errorMessage = "An error occurred. Please try again.";
        if (responseData.containsKey("status") && responseData["status"]["message"] != null) {
          errorMessage = responseData["status"]["message"];
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("An error occurred. Please try again."),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

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
                'Sign up',
                style: TextStyle(
                  color: Color(0xFF755DC1),
                  fontSize: 27,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 30),

              _buildTextField(
                _nameController,
                "Name",
                "Enter full name",
                _nameError,
              ),
              _buildTextField(
                _emailController,
                "Email",
                "Enter a valid Email",
                _emailError,
              ),
              _buildTextField(
                _phoneController,
                "Phone",
                "Enter phone number",
                _phoneError,
              ),
              _buildTextField(
                _passController,
                "Password",
                "Create a strong password",
                _passError,
                obscureText: true,
              ),

              SizedBox(
                width: 329,
                height: 56,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _signUp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF9F7BFF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child:
                      _isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                            'Create account',
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

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Have an account?',
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
                      widget.controller.animateToPage(
                        0,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                    },
                    child: const Text(
                      'Log In',
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
              const SizedBox(height: 20),

              Row(
                children: [
                  Expanded(child: Divider(color: Color(0xFF837E93))),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      'Or sign up with',
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

              SizedBox(
                width: 329,
                height: 56,
                child: ElevatedButton.icon(
                  onPressed: () {
                    // TODO: Implement Google sign-up logic
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: const BorderSide(color: Color(0xFF837E93)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  icon: Image.asset(
                    'assets/icons/google.png',
                    width: 24,
                    height: 24,
                  ),
                  label: const Text(
                    'Sign up with Google',
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

  Widget _buildTextField(
    TextEditingController controller,
    String label,
    String hint,
    String? error, {
    bool obscureText = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 56,
          child: TextField(
            controller: controller,
            textAlign: TextAlign.center,
            obscureText: obscureText,
            decoration: InputDecoration(
              labelText: label,
              hintText: hint,
              hintStyle: const TextStyle(
                color: Color(0xFF837E93),
                fontSize: 10,
              ),
              labelStyle: const TextStyle(
                color: Color(0xFF755DC1),
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(width: 1, color: Color(0xFF837E93)),
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(width: 1, color: Color(0xFF9F7BFF)),
              ),
            ),
          ),
        ),
        if (error != null)
          Padding(
            padding: const EdgeInsets.only(top: 5, left: 12),
            child: Text(
              error,
              style: const TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
        const SizedBox(height: 17),
      ],
    );
  }
}
