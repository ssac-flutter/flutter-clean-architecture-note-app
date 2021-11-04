import 'package:note_app/core/result.dart';
import 'package:note_app/data/data_source/local/note_data_source.dart';
import 'package:note_app/domain/model/note.dart';
import 'package:note_app/domain/repository/note_repository.dart';

class NoteRepositoryImpl implements NoteRepository {
  NoteDataSource dataSource;

  NoteRepositoryImpl(this.dataSource);

  @override
  Future<void> deleteNote(Note note) async {
    await dataSource.deleteNote(note);
  }

  @override
  Future<Result<Note>> getNoteById(int id) async {
    Note? note = await dataSource.getNoteById(id);

    if (note != null) {
      return Result.success(note);
    }

    return const Result.error('노트가 없습니다');
  }

  @override
  Future<List<Note>> getNotes() async {
    return await dataSource.getNotes();
  }

  @override
  Future<void> insertNote(Note note) async {
    await dataSource.insertNote(note);
  }

  @override
  Future<void> updateNote(Note note) async {
    await dataSource.updateNote(note);
  }

}