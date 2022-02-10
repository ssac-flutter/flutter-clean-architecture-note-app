
import 'package:flutter/material.dart';
import 'package:note_app/domain/model/note.dart';
import 'package:note_app/domain/use_case/note_use_cases.dart';
import 'package:note_app/domain/util/note_order.dart';
import 'package:note_app/presentation/notes/notes_event.dart';
import 'package:note_app/presentation/notes/notes_state.dart';
import 'package:get/get.dart';

class NotesViewModel extends GetxController {
  final NoteUseCases _useCases;

  Rx<NotesState> state = NotesState().obs;

  Note? _recentlyDeletedNote;

  NotesViewModel(this._useCases) {
    _loadNotes();
  }

  void onEvent(NotesEvent event) {
    event.when(
      deleteNote: _deleteNote,
      restoreNote: _restoreNote,
      loadNotes: _loadNotes,
      changeOrder: (NoteOrder noteOrder) {
        state.value = state.value.copyWith(
          noteOrder: noteOrder,
        );
        _loadNotes();
      },
    );
  }

  Future<void> _loadNotes() async {
    List<Note> notes = await _useCases.getNotes(state.value.noteOrder);
    state.value = state.value.copyWith(
      notes: notes,
    );
  }

  Future<void> _deleteNote(Note note) async {
    await _useCases.deleteNote(note);
    _recentlyDeletedNote = note;

    _loadNotes();
  }

  Future<void> _restoreNote() async {
    if (_recentlyDeletedNote != null) {
      await _useCases.addNote(_recentlyDeletedNote!);
      _recentlyDeletedNote = null;

      _loadNotes();
    }
  }
}
