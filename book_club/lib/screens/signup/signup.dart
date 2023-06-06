// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:book_club/screens/signup/localwidgets/signupform.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

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
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    BackButton(),
                  ],
                ),
                const SizedBox(height: 20),
                SignUpForm(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
