import 'package:book_club/screens/signup/signup.dart';
import 'package:book_club/utils/theme.dart';
import 'package:book_club/widgets/globalcontainer.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return GlobalContainer(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 8,
            ),
            child: Text(
              'Access your account',
              style: TextStyle(
                color: Themes.whiteColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          _inputEmail(),
          const SizedBox(height: 15),
          _inputPassword(),
          const SizedBox(height: 30),
          _logInButton(),
          const SizedBox(height: 10),
          _registerRow(context)
        ],
      ),
    );
  }

// Password text form field
  TextFormField _inputPassword() {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        prefixIcon: const Icon(
          Icons.lock_outline,
        ),
        hintText: 'Password',
        hintStyle: const TextStyle(
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }

// Email text form field
  TextFormField _inputEmail() {
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        prefixIcon: const Icon(
          Icons.alternate_email,
        ),
        hintText: 'Email',
        hintStyle: const TextStyle(
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }

// Login button
  ElevatedButton _logInButton() {
    return ElevatedButton(
      //TODO: pass a function to the following variable for _logInButton
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: Themes.redColor,
        foregroundColor: Themes.whiteColor,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 100),
        child: Text(
          'Log-in!',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

// Register row segment START
  Row _registerRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.only(
            left: 10,
            right: 10,
          ),
          child: Text(
            "Don't have an account?",
            style: TextStyle(
              fontSize: 16,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        // logic separated to another method so that it won't fuck up the styling in the non-interactive text widget
        _registerButton(context)
      ],
    );
  }

  TextButton _registerButton(BuildContext context) {
    return TextButton(
      //TODO: pass a function to the following variable for _registerButton
      onPressed: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => SignUpScreen()));
      },
      style: TextButton.styleFrom(
          textStyle: const TextStyle(
        fontSize: 16,
        fontStyle: FontStyle.italic,
      )),
      child: const Padding(
        padding: EdgeInsets.only(right: 10),
        child: Text(
          "Register!",
        ),
      ),
    );
  }
// Register row segment END
}
