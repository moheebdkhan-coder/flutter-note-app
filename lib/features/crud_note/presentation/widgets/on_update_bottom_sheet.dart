import 'package:flutter/material.dart';
import 'package:note_app/features/crud_note/presentation/widgets/update_note_textfield.dart';

class OnUpdateBottomSheet extends StatelessWidget {
  const OnUpdateBottomSheet({
    super.key,
    required this.onUpdate,
    required this.titleController,
    required this.bodyController,
  });
  final Future<void> Function() onUpdate;
  final TextEditingController titleController;
  final TextEditingController bodyController;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[900],
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Update Note",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            UpdateNoteTextfield(
              myController: titleController,
              hintText: "Title",
            ),
            UpdateNoteTextfield(
              myController: bodyController,
              hintText: "Content",
            ),
            SizedBox(height: 20),
            TextButton(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.blueGrey[800]),
              ),
              onPressed: () async {
                await onUpdate();
              },
              child: Text(
                "Update",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
