import 'package:flutter/material.dart';
import 'package:new_notes_app_flutter/models/note_model.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:sqflite/sqflite.dart';

class DbHelper extends ChangeNotifier {
  String dbName = 'Notes.db';
  static const tableName = 'NotesTable';
  String colNoteId = 'ID';
  static const String colNoteTitle = 'Title';
  static const String colNoteBody = 'Body';
  static const String colTimeStamp = 'TimeStamp';

  DbHelper._singletonConstructor();

  static DbHelper instance = DbHelper._singletonConstructor();

  Database? _database;

  Future<Database> get database async {
    if (_database == null) {
      _database = await _createDatabase();
      return _database!;
    } else {
      return _database!;
    }
  }

  Future<Database> _createDatabase() async {
    var dbPath = path.join((await _getLocalStoragePath()), dbName);

    return await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
            CREATE TABLE IF NOT EXISTS $tableName(
              $colNoteId INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
              $colNoteTitle TEXT NOT NULL,
              $colNoteBody TEXT NOT NULL,
              $colTimeStamp INTEGER NOT NULL
            )
          ''');
      },
    );
  }

  Future<String> _getLocalStoragePath() async {
    return (await path_provider.getApplicationDocumentsDirectory()).path;
  }

  Future<int> addNote(NoteModel note) async {
    Database db = await DbHelper.instance.database;
    return db.transaction((txn) async {
      var insert = txn.insert(tableName, note.noteToMap());
      notifyListeners();
      return insert;
    });
  }

  Future<List<NoteModel>> get notes async {
    List<Map<String, Object?>> notesList = [];

    notesList = await (await DbHelper.instance.database).transaction((txn) {
      return txn.query(
        tableName,
      );
    });

    List<NoteModel> noteModelList = [];

    for (var element in notesList) {
      noteModelList.add(NoteModel.fromMap(element));
    }

    return noteModelList;
  }

  Future<int> deleteNote(NoteModel note) async {
    return (await DbHelper.instance.database).transaction((txn) async {
      var delete = await txn.delete(
        tableName,
        where: '''
      $colNoteTitle IS "${note.title}" AND $colNoteBody IS "${note.body}"
      ''',
      );
      notifyListeners();
      return delete;
    });
  }

  Future<int> updateNote(NoteModel oldNote, NoteModel newNote) async {
    Map<String, Object?> noteMap = newNote.noteToMap();
    return (await DbHelper.instance.database).transaction((txn) async {
      var update = await txn.update(tableName, noteMap, where: '''
        $colNoteTitle = "${oldNote.title}" AND $colNoteBody = "${oldNote.body}"
        ''');
      notifyListeners();
      return update;
    });
  }
}
