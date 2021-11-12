import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:note_app/domain/model/note.dart';
import 'package:note_app/domain/util/note_order.dart';

part 'notes_event.freezed.dart';

@freezed
abstract class NotesEvent with _$NotesEvent {

  const factory NotesEvent.deleteNote(Note note) = DeleteNote;

  const factory NotesEvent.restoreNote() = RestoreNote;

  const factory NotesEvent.loadNotes() = LoadNotes;

  const factory NotesEvent.changeOrder(NoteOrder noteOrder) = ChangeOrder;
}
