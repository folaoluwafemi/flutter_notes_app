import 'package:new_notes_app_flutter/database/dbHelper.dart';

extension MilliSecondsSinceEpoch on int {
  DateTime millisToDateTime() => DateTime.fromMillisecondsSinceEpoch(this);
}

extension Mapping on NoteModel {
  Map<String, Object> noteToMap() => NoteModel.toMap(this);
}

class NoteModel {
  final String title;
  final DateTime timeStamp;
  final String body;

  NoteModel({
    required this.title,
    required this.body,
    required this.timeStamp,
  });

  factory NoteModel.fromMap(Map<String, Object?> noteFromDb) =>
      _noteFromMap(noteFromDb);

  static Map<String, Object> toMap(NoteModel note) => _noteToMap(note);
}

NoteModel _noteFromMap(Map<String, Object?> noteFromDb) {
  String title = '';
  String body = '';
  int dateTimeMillis = 0;

  title = noteFromDb[DbHelper.colNoteTitle].toString();
  body = noteFromDb[DbHelper.colNoteBody].toString();
  dateTimeMillis = int.parse(noteFromDb[DbHelper.colTimeStamp].toString());

  return NoteModel(
      title: title, body: body, timeStamp: dateTimeMillis.millisToDateTime());
}

Map<String, Object> _noteToMap(NoteModel note) {
  return <String, Object>{
    DbHelper.colNoteTitle: note.title,
    DbHelper.colNoteBody: note.body,
    DbHelper.colTimeStamp: note.timeStamp.millisecondsSinceEpoch,
  };
}
