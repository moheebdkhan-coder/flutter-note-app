import 'package:flutter/material.dart';

class UpdateNoteTextfield extends StatelessWidget {
  const UpdateNoteTextfield({
    super.key,
    required this.myController,
    required this.hintText,
  });
  final TextEditingController myController;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: myController,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.white54),
      ),
    );
  }
}
