import 'package:flutter/material.dart';

class LongPressContainer extends StatelessWidget {
  const LongPressContainer({
    super.key,
    required this.onDelete,
    required this.onUpdate,
  });
  final Future<void> Function() onDelete;
  final Future<void> Function() onUpdate;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[900],
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            onTap: () async {
              await onDelete();
            },
            leading: Icon(Icons.delete, color: Colors.red),
            title: Text("Delete"),
          ),
          ListTile(
            onTap: () async {
              await onUpdate();
            },
            leading: Icon(Icons.edit, color: Colors.blueGrey),
            title: Text("Edit"),
          ),
        ],
      ),
    );
  }
}
