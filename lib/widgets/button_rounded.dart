import 'dart:ffi';

import 'package:flutter/material.dart';

class ButtonRounded extends StatelessWidget {
  ButtonRounded({required this.buttonText, required this.onpress});

  final String buttonText;
  final void Function() onpress;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: ElevatedButton(
        onPressed: onpress,
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          padding: const EdgeInsets.symmetric(vertical: 20),
        ),
        child: Text(
          buttonText,
          style: TextStyle(fontSize: 17),
        ),
      ),
    );
  }
}
