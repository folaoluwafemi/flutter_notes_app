import 'package:flutter/material.dart';
import 'package:new_notes_app_flutter/database/dbHelper.dart';
import 'package:new_notes_app_flutter/models/note_model.dart';
import 'package:new_notes_app_flutter/screens/EditNoteScreen.dart';
import 'package:new_notes_app_flutter/screens/add_note_screen.dart';
import 'package:new_notes_app_flutter/screens/onboarding.dart';
import 'package:provider/provider.dart';

import 'screens/note_screen.dart';

void main() {
  runApp(ChangeNotifierProvider<DbHelper>(
    create: (context)=>DbHelper.instance,
    child: const MyNotesApp(),
  ));
}

class MyNotesApp extends StatelessWidget {
  const MyNotesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: OnboardingScreen.id,
      onGenerateRoute: (settings) {
        if (settings.name == OnboardingScreen.id) {
          return MaterialPageRoute(
              builder: (context) => const OnboardingScreen());
        }
        if (settings.name == NoteScreen.id) {
          return MaterialPageRoute(builder: (context) => const NoteScreen());
        }
        if (settings.name == AddNoteScreen.id) {
          return MaterialPageRoute(builder: (context) => const AddNoteScreen());
        }
        if (settings.name == EditNoteScreen.id) {
          if (settings.arguments != null) {
            NoteModel noteArgs = settings.arguments as NoteModel;
            return MaterialPageRoute(
              builder: (context) => EditNoteScreen(note: noteArgs),
            );
          } else {
            NoteModel noteArgs =
                NoteModel(title: '', body: '', timeStamp: DateTime.now());
            return MaterialPageRoute(
                builder: (context) => EditNoteScreen(note: noteArgs));
          }
        } else {
          return MaterialPageRoute(builder: (context) {
            return const SafeArea(
              child: Scaffold(
                body: Center(
                  child: Text('You navigated to the wrong place!!'),
                ),
              ),
            );
          });
        }
      },
    );
  }
}
