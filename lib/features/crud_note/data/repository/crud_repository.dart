import 'package:note_app/core/hive_keys/hive_keys.dart';
import 'package:note_app/features/crud_note/data/datasource/note_hive_local_db.dart';
import 'package:note_app/features/crud_note/data/models/note_model.dart';

class CrudRepository {
  final NoteHiveLocalDb db;

  CrudRepository({required this.db});

  Future<void> addNote(NoteModel note) async {
    await db.notes!.add({
      HiveKeys.titleKey: note.title,
      HiveKeys.bodyKey: note.body,
    });
  }

  Future<void> deleteNote(int id) async {
    await db.notes!.delete(id);
  }

  Future<List<NoteModel>> getAllNotes() async {
    return await db.getAllNotes();
  }

  Future<void> updateNote(int index, NoteModel note) async {
    await db.notes!.putAt(index, {
      HiveKeys.titleKey: note.title,
      HiveKeys.bodyKey: note.body,
    });
  }
}
