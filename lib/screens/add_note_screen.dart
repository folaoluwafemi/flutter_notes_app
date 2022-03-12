import 'package:flutter/material.dart';
import 'package:new_notes_app_flutter/database/dbHelper.dart';
import 'package:new_notes_app_flutter/models/note_model.dart';
import 'package:new_notes_app_flutter/utils/util_methods.dart';

class AddNoteScreen extends StatefulWidget {
  static const id = '/add_note_screen';

  const AddNoteScreen({Key? key}) : super(key: key);

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String title = '';
  String body = '';

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).canvasColor,
            shadowColor: Colors.transparent,
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
              'Add a note',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 5,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                        ),
                        child: SizedBox(
                          height: 75,
                          width: constraints.maxWidth - 20,
                          child: TextFormField(
                            style: const TextStyle(fontSize: 18),
                            decoration: addNoteTextFieldDecoration()
                                .copyWith(hintText: 'Title'),
                            onChanged: (value) {
                              title = value;
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
                          child: TextFormField(
                            maxLines: null,
                            style: const TextStyle(fontSize: 18),
                            decoration: addNoteTextFieldDecoration()
                                .copyWith(hintText: 'Enter Note here...'),
                            onChanged: (value) {
                              body = value;
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (title != '' && body != '') {
                      await DbHelper.instance.addNote(
                        NoteModel(
                          title: title,
                          body: body,
                          timeStamp: DateTime.now(),
                        ),
                      );
                      Navigator.of(context).pop();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Enter a valid note'),
                        ),
                      );
                    }
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
