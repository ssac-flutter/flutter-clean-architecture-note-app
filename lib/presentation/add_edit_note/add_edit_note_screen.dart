import 'dart:async';

import 'package:flutter/material.dart';
import 'package:note_app/domain/model/note.dart';
import 'package:note_app/presentation/add_edit_note/add_edit_note_event.dart';
import 'package:note_app/presentation/add_edit_note/add_edit_note_view_model.dart';
import 'package:note_app/ui/colors.dart' as app_color;
import 'package:provider/provider.dart';

class AddEditNoteScreen extends StatefulWidget {
  final Note? note;

  const AddEditNoteScreen({Key? key, this.note}) : super(key: key);

  @override
  State<AddEditNoteScreen> createState() => _AddEditNoteScreenState();
}

class _AddEditNoteScreenState extends State<AddEditNoteScreen> {
  final TextEditingController _titleTextController = TextEditingController();
  final TextEditingController _contentTextController = TextEditingController();
  StreamSubscription? _streamSubscription;

  final _colorList = [
    app_color.roseBud.value,
    app_color.wisteria.value,
    app_color.illusion.value,
    app_color.primrose.value,
    app_color.skyBlue.value,
  ];

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final viewModel = context.read<AddEditNoteViewModel>();
      if (widget.note != null) {
        viewModel.onEvent(AddEditNoteEvent.changeColor(widget.note!.color));
        _titleTextController.value = TextEditingValue(text: widget.note!.title);
        _contentTextController.value =
            TextEditingValue(text: widget.note!.content);
      }

      _streamSubscription = viewModel.eventStream.listen((event) {
        event.when(
          saveNote: () {
            Navigator.pop(context, true);
          },
          showSnackBar: (message) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(message)),
            );
          },
        );
      });
    });
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    _titleTextController.dispose();
    _contentTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<AddEditNoteViewModel>();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_titleTextController.text.isEmpty ||
              _contentTextController.text.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('제목 또는 내용을 입력해주세요.'),
            ));
            return;
          }

          context.read<AddEditNoteViewModel>().onEvent(
              AddEditNoteEvent.saveNote(widget.note?.id,
                  _titleTextController.text, _contentTextController.text));
        },
        child: const Icon(Icons.create),
      ),
      body: SafeArea(
        child: Container(
          color: Color(viewModel.color),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16.0,
                  horizontal: 6.0,
                ),
                child: Text(
                  widget.note == null ? '노트 작성' : '노트 편집',
                  style: const TextStyle(
                      fontSize: 36.0, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                child: FittedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: _colorList
                        .map(
                          (color) => InkWell(
                            onTap: () {
                              _changeBackgroundColor(color);
                            },
                            child: _buildBackgroundSelector(
                              color: color,
                              selected: viewModel.color == color,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    TextField(
                      controller: _titleTextController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: '제목 입력...',
                      ),
                    ),
                    TextField(
                      controller: _contentTextController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: '내용 입력...',
                      ),
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBackgroundSelector(
      {required int color, required bool selected}) {
    var decoration = BoxDecoration(
      shape: BoxShape.circle,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          spreadRadius: 1.0,
          blurRadius: 1.0,
        ),
      ],
      color: Color(color),
    );

    if (selected) {
      decoration = decoration.copyWith(
        border: Border.all(
          color: Colors.black.withOpacity(0.6),
          width: 1.0,
        ),
      );
    }
    return Container(
      width: 32.0,
      height: 16.0,
      decoration: decoration,
    );
  }

  void _changeBackgroundColor(int color) {
    final viewModel = context.read<AddEditNoteViewModel>();
    viewModel.onEvent(AddEditNoteEvent.changeColor(color));
  }
}
