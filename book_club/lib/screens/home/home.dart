// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:book_club/common/commons.dart';
import 'package:book_club/screens/nogroup/nogroup.dart';
import 'package:book_club/states/current_user.dart';
import 'package:book_club/widgets/globalcontainer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void signOut(BuildContext context) async {
    CurrentUser currentUser = Provider.of<CurrentUser>(context, listen: false);
    String returnString = await currentUser.signOut();
    if (returnString == 'success') {
      Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
    }
  }

  void developerNotice(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Feature unavailable!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _goToNoGroup(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NoGroupScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          const SizedBox(height: 40),
          listCard("Harry Potter and the Sorcerer's stone", "5 Days", context),
          const SizedBox(height: 10),
          nextReveal("10 Days"),
          const SizedBox(height: 10),
          groupsButton(context),
          const SizedBox(height: 30),
          signOutButton(context),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  // Bespoke infocard widget
  Widget listCard(String title, String count, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: GlobalContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title, // Pass a string variable here
              style: TextStyle(
                  fontSize: 28,
                  color: Themes.whiteColor,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w200),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Row(
                children: [
                  Text(
                    'Due in: ',
                    style: TextStyle(
                      fontSize: 28,
                      color: Themes.whiteColor,
                    ),
                  ),
                  Text(
                    count, // Pass a variable here
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () => developerNotice(context),
              child: Text(
                'Mark as finished!',
                style: NativeStyles.commonTxtStyle,
              ),
              style: NativeStyles.specialBtnStyle,
            ),
          ],
        ),
      ),
    );
  }

  Widget nextReveal(String count) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: GlobalContainer(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Row(
              children: [
                Text(
                  'Next reveal in: ',
                  style: TextStyle(
                    fontSize: 28,
                    color: Themes.whiteColor,
                  ),
                ),
                Text(
                  count, // Pass a variable here
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                )
              ],
            ),
          )
        ]),
      ),
    );
  }

  Widget groupsButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 100.0),
      child: ElevatedButton(
        onPressed: () => _goToNoGroup(context),
        style: NativeStyles.specialBtnStyle,
        child: Text(
          'Groups',
          style: NativeStyles.commonTxtStyle,
        ),
      ),
    );
  }

  Widget signOutButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 100.0),
      child: ElevatedButton(
        onPressed: () => signOut(context),
        style: NativeStyles.commonBtnStyle,
        child: Text(
          'Sign Out',
          style: NativeStyles.commonTxtStyle,
        ),
      ),
    );
  }
}
