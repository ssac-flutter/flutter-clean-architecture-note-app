import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:note_app/domain/model/note.dart';

part 'notes_event.freezed.dart';

@freezed
abstract class NotesEvent with _$NotesEvent {

  const factory NotesEvent.deleteNote(Note note) = DeleteNote;

  const factory NotesEvent.restoreNote() = RestoreNote;
}
