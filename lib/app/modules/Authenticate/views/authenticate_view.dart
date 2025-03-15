import 'package:flutter/material.dart';
import 'package:smart_recipe_generator_flutter/app/modules/Authenticate/views/screens/Loginpage.dart';
import 'package:smart_recipe_generator_flutter/app/modules/Authenticate/views/screens/Signuppage.dart';
import 'package:smart_recipe_generator_flutter/app/modules/Authenticate/views/screens/VerifyScreen.dart';


class AuthenticateView extends StatefulWidget {
  const AuthenticateView({super.key});

  @override
  State<AuthenticateView> createState() => _MainViewState();
}

class _MainViewState extends State<AuthenticateView> {
  PageController controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 3,
        controller: controller,
        itemBuilder: (context, index) {
          if (index == 0) {
            return LoginScreen(
              controller: controller,
            );
          } else if (index == 1) {
            return SignUpScreen(
              controller: controller,
            );
          } else {
            return VerifyScreen(
              controller: controller,
            );
          }
        },
      ),
    );
  }
}