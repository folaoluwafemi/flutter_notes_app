import 'package:flutter/material.dart';
import 'package:new_notes_app_flutter/database/dbHelper.dart';
import 'package:new_notes_app_flutter/models/note_model.dart';
import 'package:new_notes_app_flutter/utils/util_methods.dart';

class EditNoteScreen extends StatefulWidget {
  static const String id = '/editNoteScreen';
  final NoteModel note;

  const EditNoteScreen({
    required this.note,
    Key? key,
  }) : super(key: key);

  @override
  _EditNoteScreenState createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  String newTitle = '';
  String newBody = '';
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  @override
  void initState() {
    newTitle = widget.note.title;
    newBody = widget.note.body;
    _titleController.text = widget.note.title;
    _bodyController.text = widget.note.body;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).canvasColor,
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
            ),
            title: const Text(
              'Edit Note',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            shadowColor: Colors.transparent,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 5,
                ),
                Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                      ),
                      child: SizedBox(
                        height: 75,
                        width: constraints.maxWidth - 20,
                        child: TextField(
                          controller: _titleController,
                          style: const TextStyle(fontSize: 18),
                          decoration: addNoteTextFieldDecoration()
                              .copyWith(hintText: 'Title'),
                          onChanged: (value) {
                            newTitle = value;
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                      ),
                      child: SizedBox(
                        height: 500,
                        width: constraints.maxWidth - 20,
                        child: TextField(
                          controller: _bodyController,
                          maxLines: null,
                          style: const TextStyle(fontSize: 18),
                          decoration: addNoteTextFieldDecoration()
                              .copyWith(hintText: 'Enter Note here...'),
                          onChanged: (value) {
                            newBody = value;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (newTitle == '' || newBody == '') {
                      await DbHelper.instance.deleteNote(widget.note);
                    } else {
                      NoteModel newNote = NoteModel(
                          title: newTitle,
                          body: newBody,
                          timeStamp: DateTime.now());
                      await DbHelper.instance.updateNote(widget.note, newNote);
                    }
                    Navigator.of(context).pop();
                  },
                  child: const Text('Done'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
