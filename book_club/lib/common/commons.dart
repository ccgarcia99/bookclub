import 'package:flutter/material.dart';

import '../utils/theme.dart';

class ImgPath {
  static const googlePath = 'assets/images/google.png';
  static const loginEmotePath = 'assets/images/loginEmote.png';
  static const logoPath = 'assets/images/logo.png';
}

class NativeStyles {
  static ButtonStyle commonBtnStyle = ElevatedButton.styleFrom(
    backgroundColor: Themes.redColor,
    foregroundColor: Themes.whiteColor,
    minimumSize: const Size(double.infinity, 50),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
  );

  static ButtonStyle specialBtnStyle = ElevatedButton.styleFrom(
    backgroundColor: Colors.black,
    foregroundColor: Colors.white,
    minimumSize: const Size(double.infinity, 50),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    side: const BorderSide(
      color: Colors.white,
      width: 1.2,
      style: BorderStyle.solid,
    ),
  );

  static TextStyle commonTxtStyle =
      const TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
}
