import 'package:note_app/core/data_case.dart';
import 'package:note_app/domain/model/note.dart';
import 'package:note_app/domain/repository/note_repository.dart';

class UpdateNoteUseCase extends UseCase<void, Note> {
  NoteRepository repository;

  UpdateNoteUseCase(this.repository);

  @override
  Future<void> call(Note note) async {
    await repository.updateNote(note);
  }
}
