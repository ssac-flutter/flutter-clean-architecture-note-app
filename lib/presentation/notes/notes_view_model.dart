import 'package:flutter/material.dart';
import 'package:note_app/core/data_case.dart';
import 'package:note_app/domain/model/note.dart';
import 'package:note_app/domain/use_case/note_use_cases.dart';
import 'package:note_app/presentation/notes/notes_event.dart';
import 'package:note_app/presentation/notes/notes_state.dart';

class NotesViewModel with ChangeNotifier {
  NoteUseCases useCases;

  NotesState _state = NotesState();

  NotesState get state => _state;

  Note? recentlyDeletedNote;

  NotesViewModel(this.useCases) {
    _loadNotes();
  }

  void onEvent(NotesEvent event) {
    event.when(
      loadNotes: _loadNotes,
      deleteNote: _deleteNote,
      restoreNote: _restoreNote,
    );
  }

  void _loadNotes() async {
    List<Note> notes = await useCases.getNotes(NoParams());
    _state = state.copyWith(
      notes: notes,
    );
    notifyListeners();
  }

  void _deleteNote(Note note) async {
    await useCases.deleteNote(note);
    recentlyDeletedNote = note;

    _loadNotes();
  }

  void _restoreNote() async {
    if (recentlyDeletedNote != null) {
      await useCases.addNote(recentlyDeletedNote!);
      recentlyDeletedNote = null;

      _loadNotes();
    }
  }
}
