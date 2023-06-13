// ignore_for_file: prefer_final_fields, use_build_context_synchronously

import 'package:book_club/screens/root/root.dart';
import 'package:book_club/services/database.dart';
import 'package:book_club/states/current_user.dart';
import 'package:book_club/widgets/globalcontainer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/commons.dart';

class CreateGroup extends StatefulWidget {
  const CreateGroup({super.key});

  @override
  State<CreateGroup> createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  void _createGroup(BuildContext context, String groupName) async {
    CurrentUser currentUser = Provider.of<CurrentUser>(context, listen: false);
    String returnString = await NativeDatabase()
        .createGroup(groupName, currentUser.getCurrentUsr.uid);
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


  TextEditingController _groupNameController = TextEditingController();

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
                  inputGroupName(),
                  const SizedBox(height: 30),
                  createGroupButton(context)
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }

  Text headerText() => const Text(
        'Create a group',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.0,
          wordSpacing: 2.0,
        ),
      );

  TextFormField inputGroupName() {
    return TextFormField(
      controller: _groupNameController,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        prefixIcon: const Icon(
          Icons.alternate_email,
        ),
        hintText: 'Enter group name',
        hintStyle: const TextStyle(
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }

  ElevatedButton createGroupButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _createGroup(context, _groupNameController.text),
      style: NativeStyles.commonBtnStyle,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 100),
        child: Text(
          'Create group!',
          style: NativeStyles.commonTxtStyle,
        ),
      ),
    );
  }
}
