import 'package:flutter/material.dart';
import 'package:new_notes_app_flutter/screens/note_screen.dart';

import 'note_screen.dart';

class OnboardingScreen extends StatelessWidget {
  static const id = '/';

  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => SafeArea(
        child: Scaffold(
          body: Center(
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(NoteScreen.id);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: 'note_image',
                    child: Image.asset(
                      'assets/images/note_taking.png',
                      height: 60,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'notes',
                    // textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
