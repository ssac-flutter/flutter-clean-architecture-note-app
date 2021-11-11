import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note_app/presentation/add_edit_note/add_edit_note_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({Key? key}) : super(key: key);

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
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
        children: [
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
            children: [
              fileStack(),
              fileStack(),
              fileStack(),
              fileStack(),
              fileStack(),
            ],
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddEditNoteScreen()),
          );
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
          child: Image.network('https://raw.githubusercontent.com/kyoungkyoung/flutter-clean-architecture-note-app/master/img/roseBudfolder.png'),
        ),
        // Positioned(top: 20, left: 20, child: Text('노트 제목')),
        Container(
          alignment: Alignment.center,
          child: const Text('폴더 이름'),
        ),
        Container(
          alignment: Alignment.bottomRight,
          child: const Icon(Icons.delete),
        ),
      ],
    );
  }

  Container fileStack() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFE7ED9B),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                '파일 제목',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                '내용',
                style: TextStyle(
                  fontSize: 12,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          Container(
            alignment: Alignment.bottomRight,
            child: const Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}