import 'package:flutter/material.dart';
import 'package:new_notes_app_flutter/database/dbHelper.dart';
import 'package:new_notes_app_flutter/models/note_model.dart';
import 'package:new_notes_app_flutter/screens/add_note_screen.dart';
import 'package:new_notes_app_flutter/utils/custom_widgets.dart';
import 'package:provider/provider.dart';

class NoteScreen extends StatefulWidget {
  static const id = '/note_screen';

  const NoteScreen({Key? key}) : super(key: key);

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Hero(
            tag: 'note_image',
            child: Center(
              child: Image.asset(
                'assets/images/note_taking.png',
                width: 36,
              ),
            ),
          ),
          backgroundColor: Theme.of(context).canvasColor,
          shadowColor: Colors.transparent,
        ),
        body: Column(
          children: [
            FutureBuilder<List<NoteModel>>(
              future: Provider.of<DbHelper>(context).notes,
              builder: (context, AsyncSnapshot<List<NoteModel>> snapshot) {
                if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                List<NoteModel> listOfNotes = snapshot.data!;

                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: listOfNotes.length,
                  itemBuilder: (context, index) {
                    NoteModel note = listOfNotes[index];
                    return NoteView(
                      note: note,
                      navigateContext: this.context,
                      deleteCallback: () {
                        setState(() {
                          DbHelper.instance.deleteNote(note);
                        });
                      },
                    );
                  },
                );
              },
            ),
          ],
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(10.0),
          child: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AddNoteScreen.id);
            },
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
