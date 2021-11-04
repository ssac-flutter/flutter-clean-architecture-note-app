import 'package:note_app/core/result.dart';
import 'package:note_app/domain/model/note.dart';

abstract class NoteRepository {
  Future<Result<Note>> getNoteById(int id);

  Future<List<Note>> getNotes();

  Future<void> insertNote(Note note);

  Future<void> updateNote(Note note);

  Future<void> deleteNote(Note note);
}
