import 'package:flutter/material.dart';

class TextInputField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  const TextInputField(
      {Key? key,
      required this.controller,
      required this.hintText,
      required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          hintText: hintText,
          filled: true,
          fillColor: const Color.fromARGB(255, 235, 233, 233),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none),
        ),
      ),
    );
  }
}
