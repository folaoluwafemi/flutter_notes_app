import 'package:flutter/material.dart';
import 'package:new_notes_app_flutter/models/note_model.dart';
import 'package:new_notes_app_flutter/screens/EditNoteScreen.dart';

class NoteCard extends StatelessWidget {
  final NoteModel note;

  const NoteCard({
    required this.note,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime noteTime = note.timeStamp;
    String date = '${noteTime.day}/${noteTime.month}';

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.only(top: 10, left: 10),
            child: Text(
              note.title,
              style: const TextStyle(fontSize: 20),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 20, top: 20),
            child: SizedBox(
              height: 55,
              child: Text(
                note.body,
              ),
            ),
          ),
          Container(
            alignment: Alignment.bottomRight,
            margin: const EdgeInsets.only(
              right: 7,
            ),
            child: Chip(
              label: Text(
                date,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NoteView extends StatefulWidget {
  final NoteModel note;
  final VoidCallback deleteCallback;
  final BuildContext navigateContext;

  const NoteView({
    required this.note,
    required this.deleteCallback,
    required this.navigateContext,
    Key? key,
  }) : super(key: key);

  @override
  State<NoteView> createState() => _NoteViewState();
}

class _NoteViewState extends State<NoteView> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        setState(() {
          isSelected = !isSelected;
        });
      },
      onTap: () {
        setState(() {
          isSelected = false;
        });
      },
      child: (!isSelected
          ? GestureDetector(
        onTap: (){
          Navigator.of(context).pushNamed(EditNoteScreen.id, arguments: widget.note);
        },
        child: NoteCard(note: widget.note),
      )
          : SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade400,
            borderRadius: const BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: IconButton(
                  icon: const Icon(
                    Icons.delete,
                  ),
                  onPressed: widget.deleteCallback,
                ),
              ),
              SizedBox(
                width: 300,
                child: NoteCard(note: widget.note),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
