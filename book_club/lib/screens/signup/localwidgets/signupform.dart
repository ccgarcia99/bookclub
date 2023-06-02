import 'package:flutter/material.dart';

import '../../../utils/theme.dart';
import '../../../widgets/globalcontainer.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});

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
              'Create your account',
              style: TextStyle(
                color: Themes.whiteColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          _registerFullName(),
          const SizedBox(height: 15),
          _registerEmail(),
          const SizedBox(height: 15),
          _confirmEmail(),
          const SizedBox(height: 15),
          _registerPassword(),
          const SizedBox(height: 15),
          _confirmPassword(),
          const SizedBox(height: 30),
          _registerButton(),
          const SizedBox(height: 15),
        ],
      ),
    );
  }

// Name text form field
  TextFormField _registerFullName() {
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        prefixIcon: const Icon(
          Icons.person_2_outlined,
        ),
        hintText: 'Enter your full name',
        hintStyle: const TextStyle(
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }

// Email text form field
  TextFormField _registerEmail() {
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

  TextFormField _confirmEmail() {
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        prefixIcon: const Icon(
          Icons.alternate_email,
        ),
        hintText: 'Confirm your email',
        hintStyle: const TextStyle(
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }

// Password text form field
  TextFormField _registerPassword() {
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

  TextFormField _confirmPassword() {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        prefixIcon: const Icon(
          Icons.lock_outline,
        ),
        hintText: 'Confirm your password',
        hintStyle: const TextStyle(
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }

// Login button
  ElevatedButton _registerButton() {
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
          'Register!',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
