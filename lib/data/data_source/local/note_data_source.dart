import 'package:note_app/domain/model/note.dart';
import 'package:sqflite/sqflite.dart';

class NoteDataSource {
  Database db;

  NoteDataSource(this.db);

  Future<Note?> getNoteById(int id) async {
    List<Map<String, dynamic>> maps = await db.query(
      'note',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Note.fromJson(maps.first);
    }
    return null;
  }

  Future<List<Note>> getNotes() async {
    List<Map<String, dynamic>> maps = await db.query('note');
    return maps.map((e) => Note.fromJson(e)).toList();
  }

  Future<void> insertNote(Note note) async {
    await db.insert('note', note.toJson());
  }

  Future<void> updateNote(Note note) async {
    await db.update(
      'note',
      note.toJson(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  Future<void> deleteNote(Note note) async {
    // DELETE FROM note WHERE id = 10;
    await db.delete('note', where: 'id = ?', whereArgs: [note.id]);
  }
}
