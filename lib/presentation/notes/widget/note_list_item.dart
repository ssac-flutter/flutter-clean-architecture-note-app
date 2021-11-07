import 'package:flutter/material.dart';
import 'package:note_app/domain/model/note.dart';

class NoteListItem extends StatelessWidget {
  final Note note;
  final void Function()? onNoteTap;
  final void Function()? onDeleteTap;

  const NoteListItem({
    Key? key,
    required this.note,
    this.onNoteTap,
    this.onDeleteTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 4.0,
      ),
      child: InkWell(
        onTap: onNoteTap,
        child: Card(
          color: Color(note.color),
          elevation: 2.0,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  note.title,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6.0),
                Text(note.content),
                const SizedBox(height: 16.0),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      DateTime.fromMillisecondsSinceEpoch(note.timestamp)
                          .toString(),
                      style: const TextStyle(fontSize: 13.0),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: onDeleteTap,
                      child: const Icon(
                        Icons.delete,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
