import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_camera/model/note.dart';
import 'package:hive_camera/screens/notes_list_screens.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Directory directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter<Note>(NoteAdapter());
  await Hive.openBox<Note>('note');
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: NotesListScreen(),
    );
  }
}

