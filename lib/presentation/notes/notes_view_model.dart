
import 'package:flutter/material.dart';
import 'package:note_app/domain/model/note.dart';
import 'package:note_app/domain/use_case/note_use_cases.dart';
import 'package:note_app/presentation/notes/notes_event.dart';
import 'package:note_app/presentation/notes/notes_state.dart';

class NotesViewModel with ChangeNotifier {
  final NoteUseCases _useCases;

  NotesState _state = NotesState();

  NotesState get state => _state;

  Note? _recentlyDeletedNote;

  NotesViewModel(this._useCases) {
    _loadNotes();
  }

  void onEvent(NotesEvent event) {
    event.when(
      deleteNote: _deleteNote,
      restoreNote: _restoreNote,
      loadNotes: _loadNotes,
    );
  }

  void _loadNotes() async {
    List<Note> notes = await _useCases.getNotes(state.noteOrder);
    _state = state.copyWith(
      notes: notes,
    );
    notifyListeners();
  }

  void _deleteNote(Note note) async {
    await _useCases.deleteNote(note);
    _recentlyDeletedNote = note;

    _loadNotes();
  }

  void _restoreNote() async {
    if (_recentlyDeletedNote != null) {
      await _useCases.addNote(_recentlyDeletedNote!);
      _recentlyDeletedNote = null;

      _loadNotes();
    }
  }
}
