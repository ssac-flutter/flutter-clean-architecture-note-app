import 'package:flutter/material.dart';
import 'package:note_app/domain/model/note.dart';

class FileStack extends StatelessWidget {
  final Note note;

  final void Function(Note note)? onDeleteTap;

  const FileStack({
    Key? key,
    required this.note,
    this.onDeleteTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 16),
      decoration: BoxDecoration(
        color: Color(note.color),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                note.title,
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                note.content,
                style: const TextStyle(
                  fontSize: 12,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              onDeleteTap?.call(note);
            },
            child: Container(
              alignment: Alignment.bottomRight,
              child: const Icon(Icons.delete),
            ),
          ),
        ],
      ),
    );
  }
}
