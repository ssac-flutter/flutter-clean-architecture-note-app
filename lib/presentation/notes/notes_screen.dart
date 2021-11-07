import 'package:flutter/material.dart';
import 'package:note_app/domain/model/note.dart';
import 'package:note_app/presentation/add_edit_note/add_edit_note_screen.dart';
import 'package:note_app/presentation/notes/notes_event.dart';
import 'package:note_app/presentation/notes/notes_view_model.dart';
import 'package:note_app/presentation/notes/widget/note_list_item.dart';
import 'package:provider/provider.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<NotesViewModel>();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _openAddEditNoteScreen(context);
        },
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(
                vertical: 16.0,
                horizontal: 6.0,
              ),
              child: Text(
                '모든 노트',
                style: TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold),
              ),
            ),
            if (viewModel.state.notes.isNotEmpty)
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final note = viewModel.state.notes[index];
                  return NoteListItem(
                    note: note,
                    onNoteTap: () {
                      _openAddEditNoteScreen(context, note);
                    },
                    onDeleteTap: () {
                      _deleteNote(context, note);
                    },
                  );
                },
                itemCount: viewModel.state.notes.length,
              )
            else
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  SizedBox(
                    height: 16.0,
                  ),
                  Text('등록된 노트가 없습니다.'),
                  Text('아래 추가버튼을 눌러, 등록하세요!'),
                ],
              ),
          ],
        ),
      ),
    );
  }

  void _openAddEditNoteScreen(BuildContext context, [Note? note]) async {
    final viewModel = context.read<NotesViewModel>();
    final isChanged = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => AddEditNoteScreen(note: note)),
    );

    if (isChanged != null && isChanged) {
      viewModel.onEvent(const NotesEvent.loadNotes());
    }
  }

  void _deleteNote(BuildContext context, Note note) {
    final viewModel = context.read<NotesViewModel>();
    viewModel.onEvent(NotesEvent.deleteNote(note));

    final snackBar = SnackBar(
      content: const Text('선택한 노트를 삭제했습니다.'),
      action: SnackBarAction(
        label: '취소',
        onPressed: () {
          viewModel.onEvent(const NotesEvent.restoreNote());
        },
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
