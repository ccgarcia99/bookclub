// ignore_for_file: prefer_final_fields

import 'package:book_club/widgets/globalcontainer.dart';
import 'package:flutter/material.dart';

import '../../common/commons.dart';

class CreateGroup extends StatefulWidget {
  const CreateGroup({super.key});

  @override
  State<CreateGroup> createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
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
      onPressed: () {},
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
