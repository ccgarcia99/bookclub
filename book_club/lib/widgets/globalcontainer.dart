import 'package:flutter/material.dart';

import '../utils/theme.dart';

class GlobalContainer extends StatelessWidget {
  final Widget? child;

  const GlobalContainer({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Themes.greyColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Themes.greyColor,
          )
        ],
      ),
      child: child,
    );
  }
}
