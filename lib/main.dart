import 'package:flutter/material.dart';
import 'package:note_app/features/crud_note/data/datasource/note_hive_local_db.dart';
import 'package:note_app/features/crud_note/data/repository/crud_repository.dart';
import 'package:note_app/features/crud_note/presentation/crud_provider/crud_note_provider.dart';
import 'package:note_app/features/crud_note/presentation/screens/crud_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  NoteHiveLocalDb db = NoteHiveLocalDb();
  if (db.notes == null) {
    await db.initNotesBox();
  }
  CrudNoteProvider provider = CrudNoteProvider(
    crudRepository: CrudRepository(db: db),
  );
  await provider.getAllNotes();
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => provider)],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CrudScreen(),
      theme: ThemeData.dark(),
    );
  }
}
