import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_app/domain/util/note_order.dart';
import 'package:note_app/presentation/add_edit_note/add_edit_note_screen.dart';
import 'package:note_app/presentation/notes/components/file_stack.dart';
import 'package:note_app/presentation/notes/components/order_section.dart';
import 'package:note_app/presentation/notes/notes_event.dart';
import 'package:note_app/presentation/notes/notes_view_model.dart';

class NotesScreen extends GetView<NotesViewModel> {
  NotesScreen({Key? key}) : super(key: key);

  final viewModel = Get.find<NotesViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xBE63E3C8),
        title: Text(
          'My Note App',
          style: GoogleFonts.combo(
            color: Colors.white,
          ),
        ),
      ),
      body: Obx(
        () {
          final state = viewModel.state.value;
          return ListView(
            padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
            children: [
              OrderSection(
                noteOrder: state.noteOrder,
                onOrderChanged: (NoteOrder newNoteOrder) {
                  viewModel.onEvent(NotesEvent.changeOrder(newNoteOrder));
                },
              ),
              GridView.count(
                crossAxisCount: 3,
                childAspectRatio: 2.0 / 1.5,
                mainAxisSpacing: 16,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  folderStack(),
                  folderStack(),
                  folderStack(),
                  folderStack(),
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
              Column(
                children: state.notes
                    .map((note) => GestureDetector(
                          onTap: () async {
                            bool? isChanged = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      AddEditNoteScreen(note: note)),
                            );

                            if (isChanged != null && isChanged) {
                              viewModel.onEvent(const NotesEvent.loadNotes());
                            }
                          },
                          child: FileStack(
                            note: note,
                            onDeleteTap: (note) {
                              viewModel.onEvent(NotesEvent.deleteNote(note));

                              final snackBar = SnackBar(
                                content: const Text('????????? ????????? ??????????????????.'),
                                action: SnackBarAction(
                                  label: '??????',
                                  onPressed: () {
                                    viewModel.onEvent(
                                        const NotesEvent.restoreNote());
                                  },
                                ),
                              );

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            },
                          ),
                        ))
                    .toList(),
              )
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          bool? isChanged = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddEditNoteScreen()),
          );

          if (isChanged != null && isChanged) {
            viewModel.onEvent(const NotesEvent.loadNotes());
          }
        },
        child: const Icon(Icons.add),
        backgroundColor: const Color(0xFF25CBA5),
      ),
    );
  }

  Stack folderStack() {
    return Stack(
      children: [
        Container(
          alignment: Alignment.center,
          child: Image.network(
              'https://raw.githubusercontent.com/kyoungkyoung/flutter-clean-architecture-note-app/master/img/roseBudfolder.png'),
        ),
        // Positioned(top: 20, left: 20, child: Text('?????? ??????')),
        Container(
          alignment: Alignment.center,
          child: const Text('?????? ??????'),
        ),
        Container(
          alignment: Alignment.bottomRight,
          child: const Icon(Icons.delete),
        ),
      ],
    );
  }
}
