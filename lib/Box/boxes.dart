import 'package:hive/hive.dart';
import 'package:hive_camera/model/note.dart';

class Boxes {
  static Box<Note> getData() => Hive.box<Note>('notes');


}