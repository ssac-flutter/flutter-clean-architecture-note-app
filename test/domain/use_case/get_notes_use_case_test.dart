import 'package:flutter_test/flutter_test.dart';
import 'package:note_app/core/data_case.dart';
import 'package:note_app/core/result.dart';
import 'package:note_app/domain/model/note.dart';
import 'package:note_app/domain/repository/note_repository.dart';
import 'package:note_app/domain/use_case/get_notes_use_case.dart';

void main() {
  test('모든 노트 목록을 가져와야 한다', () async {
    final repository = FakeNoteRepository();
    final useCase = GetNotesUseCase(repository);

    final List<Note> result = await useCase(NoParams());

    expect(result, isA<List<Note>>());

    expect(result.length, 2);

  });
}

final noteList = [
  Note(title: 'title', content: 'content', timestamp: 0, color: 1),
  Note(title: 'title2', content: 'content2', timestamp: 2, color: 2),
];

class FakeNoteRepository implements NoteRepository {
  @override
  Future<void> deleteNote(Note note) {
    // TODO: implement deleteNote
    throw UnimplementedError();
  }

  @override
  Future<Result<Note>> getNoteById(int id) {
    // TODO: implement getNoteById
    throw UnimplementedError();
  }

  @override
  Future<List<Note>> getNotes() async {
    return noteList;
  }

  @override
  Future<void> insertNote(Note note) {
    // TODO: implement insertNote
    throw UnimplementedError();
  }

  @override
  Future<void> updateNote(Note note) {
    // TODO: implement updateNote
    throw UnimplementedError();
  }

}