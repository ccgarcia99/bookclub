import 'package:book_club/common/commons.dart';
import 'package:book_club/screens/createGroup/creategroup.dart';
import 'package:book_club/screens/joinGroup/joingroup.dart';
import 'package:flutter/material.dart';

import '../../utils/theme.dart';

class NoGroupScreen extends StatelessWidget {
  const NoGroupScreen({super.key});

  void _goToJoin(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => JoinGroup(),
        ));
  }

  void _goToCreate(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CreateGroup(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(flex: 1),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
            child: Image.asset(ImgPath.logoPath, width: 150),
          ),
          // Header Text
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: header(),
          ),
          // Subtext
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: subText(),
          ),
          const Spacer(flex: 1),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                joinAGroup(context),
                createAGroup(context),
              ],
            ),
          )
        ],
      ),
    );
  }

  Padding header() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        'Welcome to Groups!',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Themes.whiteColor,
            wordSpacing: 2.5,
            letterSpacing: 1.0),
      ),
    );
  }

  Padding subText() {
    return const Padding(
      padding: EdgeInsets.all(20.0),
      child: Text(
        'Find like-minded people, or create your own community!',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Themes.whiteColor,
          wordSpacing: 1.0,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget joinAGroup(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
          onPressed: () => _goToJoin(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            minimumSize: const Size(150, 50),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            side: const BorderSide(
              color: Colors.white,
              width: 1.2,
              style: BorderStyle.solid,
            ),
          ),
          child: Text(
            'Join Group',
            style: NativeStyles.commonTxtStyle,
          )),
    );
  }

  Widget createAGroup(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () => _goToCreate(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: Themes.redColor,
          foregroundColor: Themes.whiteColor,
          minimumSize: const Size(150, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Text(
          'Create a Group',
          style: NativeStyles.commonTxtStyle,
        ),
      ),
    );
  }
}
