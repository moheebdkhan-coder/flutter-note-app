import 'package:flutter/material.dart';
import 'package:note_app/features/crud_note/data/models/note_model.dart';
import 'package:note_app/features/crud_note/data/repository/crud_repository.dart';

class CrudNoteProvider extends ChangeNotifier {
  final CrudRepository crudRepository;

  List<NoteModel>? notes;
  Future<void> getAllNotes() async {
    notes = await crudRepository.getAllNotes();
    notifyListeners();
  }

  CrudNoteProvider({required this.crudRepository});
  Future<void> addNote(String title, String body) async {
    await crudRepository.addNote(NoteModel(title: title, body: body));
    notifyListeners();
  }

  Future<void> deleteNote(int id) async {
    await crudRepository.deleteNote(id);
    notifyListeners();
  }

  Future<void> updateNote(int index, String title, String body) async {
    await crudRepository.updateNote(index, NoteModel(title: title, body: body));
    notifyListeners();
  }
}
