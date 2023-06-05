import 'package:book_club/common/commons.dart';
import 'package:book_club/screens/login/localwidgets/loginform.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _bodyRow(),
    );
  }

  Row _bodyRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Image.asset(
                    ImgPath.loginEmotePath,
                    height: 125,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Dive into anything!',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                LoginForm(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
