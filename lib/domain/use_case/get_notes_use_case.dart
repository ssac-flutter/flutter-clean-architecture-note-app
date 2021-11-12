import 'package:note_app/core/data_case.dart';
import 'package:note_app/domain/model/note.dart';
import 'package:note_app/domain/repository/note_repository.dart';
import 'package:note_app/domain/util/note_order.dart';

class GetNotesUseCase extends UseCase<List<Note>, NoteOrder> {
  NoteRepository repository;

  GetNotesUseCase(this.repository);

  @override
  Future<List<Note>> call(NoteOrder noteOrder) async {
    List<Note> notes = await repository.getNotes();

    noteOrder.when(
      title: (orderType) {
        orderType.when(
          ascending: () {
            notes = notes
              ..sort((Note a, Note b) => a.title.compareTo(b.title));
          },
          descending: () {
            notes = notes
              ..sort((Note a, Note b) => b.title.compareTo(a.title));
          },
        );
      },
      date: (orderType) {
        orderType.when(
          ascending: () {
            notes = notes
              ..sort((Note a, Note b) => a.timestamp.compareTo(b.timestamp));
          },
          descending: () {
            notes = notes
              ..sort((Note a, Note b) => b.timestamp.compareTo(a.timestamp));
          },
        );
      },
      color: (orderType) {
        orderType.when(
          ascending: () {
            notes = notes
              ..sort((Note a, Note b) => a.color.compareTo(b.color));
          },
          descending: () {
            notes = notes
              ..sort((Note a, Note b) => b.color.compareTo(a.color));
          },
        );
      },
    );

    return notes;
  }
}
