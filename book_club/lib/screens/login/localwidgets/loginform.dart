import 'package:book_club/common/commons.dart';
import 'package:book_club/screens/home/home.dart';
import 'package:book_club/screens/signup/signup.dart';
import 'package:book_club/states/current_user.dart';
import 'package:book_club/utils/theme.dart';
import 'package:book_club/widgets/globalcontainer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum LoginType {
  email,
  google,
}

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  // ignore: prefer_final_fields
  TextEditingController _emailLogIn = TextEditingController();
  // ignore: prefer_final_fields
  TextEditingController _passwordLogin = TextEditingController();

  /// Logs in the user based on the specified login type (email or Google) with optional email and password,
  /// and displays appropriate messages or navigates to the home screen.
void _logInUser({
  required LoginType type,
  String email = '',
  String password = '',
  required BuildContext context,
}) async {
  CurrentUser currentUser = Provider.of<CurrentUser>(context, listen: false);

  try {
    String returnString = '';

    switch (type) {
      case LoginType.email:
        returnString = await currentUser.logInUserwithEmail(email, password);
        break;
      case LoginType.google:
        returnString = await currentUser.logInUserwithGoogle();

        if (returnString == 'success') {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
          return; // Exit the method after successful navigation
        }
        break;
      default:
        returnString = 'Invalid login type'; // Assign a value to returnString for the default case
    }

    if (returnString == 'success') {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error signing in!'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  } catch (e) {
    print(e);
  }
}


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
          _logInButton(context),
          const SizedBox(height: 10),
          _logInWithGoogleButton(context),
          const SizedBox(height: 10),
          _registerRow(context),
        ],
      ),
    );
  }

  /// Returns a TextFormField widget for entering the email.
  TextFormField _inputEmail() {
    return TextFormField(
      controller: _emailLogIn,
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

  /// Returns a TextFormField widget for entering the password.
  TextFormField _inputPassword() {
    return TextFormField(
      controller: _passwordLogin,
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

  /// Returns an ElevatedButton widget for logging in with email and password.
  ElevatedButton _logInButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        _logInUser(
          type: LoginType.email,
          email: _emailLogIn.text,
          password: _passwordLogin.text,
          context: context,
        );
      },
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

  /// Returns an ElevatedButton widget for logging in with Google.
  ElevatedButton _logInWithGoogleButton(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        _logInUser(
          type: LoginType.google,
          context: context,
        );
      },
      icon: Image.asset(
        ImgPath.googlePath,
        width: 35,
      ),
      label: const Text(
        'Continue with Google',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      style: ElevatedButton.styleFrom(
        side: const BorderSide(
          color: Themes.whiteColor,
          width: 1.2,
          style: BorderStyle.solid,
        ),
        foregroundColor: Themes.whiteColor,
        backgroundColor: Themes.greyColor,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }

  /// Returns a Row widget containing non-interactive text and a register button.
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
        // logic separated to another method so that it won't affect the styling in the non-interactive text widget
        _registerButton(context),
      ],
    );
  }

  /// Returns a TextButton widget for navigating to the sign-up screen.
  TextButton _registerButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => SignUpScreen()));
      },
      style: TextButton.styleFrom(
        textStyle: const TextStyle(
          fontSize: 16,
          fontStyle: FontStyle.italic,
        ),
      ),
      child: const Padding(
        padding: EdgeInsets.only(right: 10),
        child: Text(
          "Register!",
        ),
      ),
    );
  }
}
