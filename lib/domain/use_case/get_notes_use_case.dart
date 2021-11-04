import 'package:note_app/core/data_case.dart';
import 'package:note_app/domain/model/note.dart';
import 'package:note_app/domain/repository/note_repository.dart';

class GetNotesUseCase extends UseCase<List<Note>, NoParams> {
  NoteRepository repository;

  GetNotesUseCase(this.repository);

  @override
  Future<List<Note>> call(NoParams params) {
    return repository.getNotes();
  }
}
