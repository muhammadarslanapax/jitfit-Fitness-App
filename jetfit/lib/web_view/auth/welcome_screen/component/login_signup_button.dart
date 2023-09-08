import 'package:flutter/material.dart';
import 'package:jetfit/utilis/theme_data.dart';
import 'package:jetfit/web_view/auth/login_screen/login.dart';
import 'package:jetfit/web_view/auth/signup_screen/signup.dart';

class LoginAndSignupBtn extends StatelessWidget {
  const LoginAndSignupBtn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Hero(
          tag: "login_btn",
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const LoginScreen();
                  },
                ),
              );
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: MyThemeData.tertiary20, elevation: 0),
            child: Text(
              "Login".toUpperCase(),
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const SignUpScreen();
                },
              ),
            );
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: MyThemeData.tertiary20, elevation: 0),
          child: Text(
            "Sign Up".toUpperCase(),
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
