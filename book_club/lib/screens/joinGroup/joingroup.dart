// ignore_for_file: prefer_final_fields, use_build_context_synchronously

import 'package:book_club/widgets/globalcontainer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/commons.dart';
import '../../services/database.dart';
import '../../states/current_user.dart';
import '../root/root.dart';

class JoinGroup extends StatefulWidget {
  const JoinGroup({super.key});

  @override
  State<JoinGroup> createState() => _JoinGroupState();
}

class _JoinGroupState extends State<JoinGroup> {
  TextEditingController _groupIdController = TextEditingController();

  void _joinGroup(BuildContext context, String groupID) async {
    CurrentUser currentUser = Provider.of<CurrentUser>(context, listen: false);
    String returnString = await NativeDatabase()
        .createGroup(groupID, currentUser.getCurrentUsr.uid);
    if (returnString == 'success') {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => RootWidget(),
        ),
        (route) => false,
      );
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[BackButton()]),
              const SizedBox(height: 20),
              GlobalContainer(
                  child: Column(
                children: [
                  headerText(),
                  const SizedBox(height: 10),
                  inputGroupId(),
                  const SizedBox(height: 30),
                  joinGroupButton(context)
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }

  Text headerText() => const Text(
        'Join a group',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.0,
          wordSpacing: 2.0,
        ),
      );

  TextFormField inputGroupId() {
    return TextFormField(
      controller: _groupIdController,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        prefixIcon: const Icon(
          Icons.alternate_email,
        ),
        hintText: 'Enter group ID',
        hintStyle: const TextStyle(
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }

  ElevatedButton joinGroupButton(BuildContext context) {
    return ElevatedButton(
      onPressed: ()=> _joinGroup(context, _groupIdController.text),
      style: NativeStyles.commonBtnStyle,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 100),
        child: Text(
          'Join group!',
          style: NativeStyles.commonTxtStyle,
        ),
      ),
    );
  }
}
