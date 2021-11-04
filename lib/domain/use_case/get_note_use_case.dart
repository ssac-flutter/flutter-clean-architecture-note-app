import 'package:note_app/core/data_case.dart';
import 'package:note_app/core/result.dart';
import 'package:note_app/domain/model/note.dart';
import 'package:note_app/domain/repository/note_repository.dart';

class GetNoteUseCase extends UseCase<Result<Note>, int> {
  NoteRepository repository;

  GetNoteUseCase(this.repository);

  @override
  Future<Result<Note>> call(int id) async {
    return await repository.getNoteById(id);
  }
}
