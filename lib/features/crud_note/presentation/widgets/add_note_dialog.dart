import 'package:flutter/material.dart';
import 'package:note_app/features/crud_note/presentation/widgets/update_note_textfield.dart';

class AddNoteDialog extends StatelessWidget {
  const AddNoteDialog({
    super.key,
    required this.titleController,
    required this.bodyController,
    required this.onAdd,
  });
  final TextEditingController titleController;
  final TextEditingController bodyController;
  final Future<void> Function() onAdd;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Add Note", textAlign: TextAlign.center),
      backgroundColor: Colors.grey[900],
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Title",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
            UpdateNoteTextfield(
              myController: titleController,
              hintText: "Title",
            ),
            SizedBox(height: 10),
            Text(
              "Body",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
            UpdateNoteTextfield(myController: bodyController, hintText: "Body"),
            SizedBox(height: 20),
            TextButton(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.blueGrey[800]),
              ),
              onPressed: () async {
                await onAdd();
                Navigator.pop(context);
              },
              child: Text("Add", textAlign: TextAlign.center),
            ),
          ],
        ),
      ),
    );
  }
}
