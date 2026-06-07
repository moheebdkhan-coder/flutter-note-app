import 'package:hive_flutter/adapters.dart';
import 'package:note_app/core/hive_keys/hive_keys.dart';
import 'package:note_app/features/crud_note/data/models/note_model.dart';

class NoteHiveLocalDb {
  Box? notes;
  Future<void> initNotesBox() async {
    await Hive.initFlutter();
    notes = await Hive.openBox(HiveKeys.boxName);
  }

  Future<List<NoteModel>> getAllNotes() async {
    return [
      for (int key in notes!.keys)
        NoteModel(
          title: notes!.get(key)[HiveKeys.titleKey],
          body: notes!.get(key)[HiveKeys.bodyKey],
        ),
    ];
  }
}
