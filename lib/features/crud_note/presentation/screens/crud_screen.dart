import 'package:flutter/material.dart';
import 'package:note_app/features/crud_note/presentation/crud_provider/crud_note_provider.dart';
import 'package:note_app/features/crud_note/presentation/widgets/add_note_dialog.dart';
import 'package:note_app/features/crud_note/presentation/widgets/long_press_container.dart';
import 'package:note_app/features/crud_note/presentation/widgets/on_update_bottom_sheet.dart';
import 'package:provider/provider.dart';

class CrudScreen extends StatefulWidget {
  const CrudScreen({super.key});

  @override
  State<CrudScreen> createState() => _CrudScreenState();
}

class _CrudScreenState extends State<CrudScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CrudNoteProvider>(
      builder: (context, value, child) {
        return Scaffold(
          key: scaffoldKey,
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              showDialog(
                context: context,
                builder: (context) {
                  return AddNoteDialog(
                    titleController: titleController,
                    bodyController: bodyController,
                    onAdd: (() async {
                      await value.addNote(
                        titleController.text.trim(),
                        bodyController.text.trim(),
                      );
                      await value.getAllNotes();
                      titleController.clear();
                      bodyController.clear();
                    }),
                  );
                },
              );
            },
            child: Icon(Icons.add, size: 40),
          ),
          appBar: PreferredSize(
            preferredSize: Size(double.infinity, 70),
            child: AppBar(
              title: Text(
                "Notes",
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ListView.builder(
              itemBuilder: (context, index) {
                List<Color> colors = [
                  Colors.yellow[600]!,
                  Colors.green[600]!,
                  Colors.orange[600]!,
                  Colors.purple[600]!,
                  Colors.lightBlue[600]!,
                  Colors.brown[600]!,
                ];
                return Card(
                  color: colors[index % colors.length],
                  child: InkWell(
                    onLongPress: () {
                      scaffoldKey.currentState!.showBottomSheet(
                        (context) => LongPressContainer(
                          onDelete: () async {
                            Iterable notesKeys =
                                value.crudRepository.db.notes!.keys;
                            await value.deleteNote(notesKeys.elementAt(index));
                            await value.getAllNotes();
                            Navigator.pop(context);
                          },
                          onUpdate: () async {
                            scaffoldKey.currentState!.showBottomSheet(
                              (context) => OnUpdateBottomSheet(
                                titleController: titleController,
                                bodyController: bodyController,
                                onUpdate: () async {
                                  await value.updateNote(
                                    index,
                                    titleController.text.trim(),
                                    bodyController.text.trim(),
                                  );
                                  await value.getAllNotes();
                                  titleController.clear();
                                  bodyController.clear();
                                  Navigator.pop(context);
                                },
                              ),
                            );
                          },
                        ),
                      );
                    },
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey[900],
                        child: Text(
                          "${index + 1}",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      title: Text(
                        value.notes![index].title,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      subtitle: Text(
                        value.notes![index].body,
                        style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                      ),
                    ),
                  ),
                );
              },
              itemCount: value.notes?.length ?? 0,
            ),
          ),
        );
      },
    );
  }
}
