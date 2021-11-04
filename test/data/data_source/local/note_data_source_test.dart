import 'package:flutter_test/flutter_test.dart';
import 'package:note_app/data/data_source/local/note_data_source.dart';
import 'package:note_app/domain/model/note.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  test('db test', () async {
    // final db = await openDatabase(
    //   'notes.db',
    //   version: 1,
    //   onCreate: (db, version) async {
    //     await db.execute('CREATE TABLE note (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, content TEXT, color INTEGER, timestamp INTEGER)');
    //   },
    // );
    final db = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);

    await db.execute('CREATE TABLE note (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, content TEXT, color INTEGER, timestamp INTEGER)');
    final dataSource = NoteDataSource(db);

    await dataSource.insertNote(Note(title: 'test', content: 'test', color: 1, timestamp: 2));

    expect((await dataSource.getNotes()).length, 1);

    Note note = (await dataSource.getNoteById(1))!;
    expect(note.id, 1);

    await dataSource.updateNote(note.copyWith(
      title: 'change',
    ));

    note = (await dataSource.getNoteById(1))!;
    expect(note.title, 'change');

    await dataSource.deleteNote(note);

    expect((await dataSource.getNotes()).length, 0);

    await db.close();
  });
}
