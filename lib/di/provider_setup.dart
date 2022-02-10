import 'package:get/get.dart';
import 'package:note_app/data/data_source/local/note_data_source.dart';
import 'package:note_app/data/repository/note_repository_impl.dart';
import 'package:note_app/domain/use_case/add_note_use_case.dart';
import 'package:note_app/domain/use_case/delete_note_use_case.dart';
import 'package:note_app/domain/use_case/get_note_use_case.dart';
import 'package:note_app/domain/use_case/get_notes_use_case.dart';
import 'package:note_app/domain/use_case/note_use_cases.dart';
import 'package:note_app/domain/use_case/update_note_use_case.dart';
import 'package:note_app/presentation/add_edit_note/add_edit_note_view_model.dart';
import 'package:note_app/presentation/notes/notes_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:sqflite/sqflite.dart';

Future<void> getProviders() async {
  final db = await openDatabase(
    'notes.db',
    version: 1,
    onCreate: (db, version) async {
      await db.execute(
          'CREATE TABLE note (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, content TEXT, color INTEGER, timestamp INTEGER)');
    },
  );

  final dataSource = NoteDataSource(db);
  final repository = NoteRepositoryImpl(dataSource);
  final useCases = NoteUseCases(
    getNotes: GetNotesUseCase(repository),
    deleteNote: DeleteNoteUseCase(repository),
    addNote: AddNoteUseCase(repository),
    updateNote: UpdateNoteUseCase(repository),
    getNote: GetNoteUseCase(repository),
  );

  Get.put(NotesViewModel(useCases));
  Get.put(AddEditNoteViewModel(useCases));
}
