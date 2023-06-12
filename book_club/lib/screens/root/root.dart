import 'package:book_club/screens/home/home.dart';
import 'package:book_club/screens/login/login.dart';
import 'package:book_club/screens/nogroup/nogroup.dart';
import 'package:book_club/screens/splashscreen/splashscreen.dart';
import 'package:book_club/states/current_user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum AuthStatus { unknown, notLoggedIn, notInGroup, inGroup }

class RootWidget extends StatefulWidget {
  const RootWidget({super.key});

  @override
  State<RootWidget> createState() => _RootWidgetState();
}

class _RootWidgetState extends State<RootWidget> {
  AuthStatus _baseState = AuthStatus.unknown;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Start an async operation
    Future.microtask(() async {
      CurrentUser currentUser =
          Provider.of<CurrentUser>(context, listen: false);
      String returnString = await currentUser.onStartup();

      if (returnString == 'success') {
        if (currentUser.getCurrentUsr.groupId != null) {
          setState(() {
            _baseState = AuthStatus.inGroup;
          });
        } else {
          setState(() {
            _baseState = AuthStatus.notInGroup;
          });
        }
      } else {
        setState(() {
          _baseState = AuthStatus.notLoggedIn;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget? retVal;

    switch (_baseState) {
      case AuthStatus.unknown:
        retVal = SplashScreen();
        break;
      case AuthStatus.notLoggedIn:
        retVal = LoginScreen();
        break;
      case AuthStatus.notInGroup:
        retVal = NoGroupScreen();
        break;
      case AuthStatus.inGroup:
        retVal = HomeScreen();
        break;
      default:
    }

    return retVal ?? Container();
  }
}
