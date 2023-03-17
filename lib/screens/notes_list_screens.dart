import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_camera/model/note.dart';
import 'package:hive_camera/screens/add_note_screen.dart';
import 'package:hive_camera/screens/view_note_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

class NotesListScreen extends StatefulWidget {
  const NotesListScreen({Key? key}) : super(key: key);

  @override
  _NotesListScreenState createState() => _NotesListScreenState();
}

class _NotesListScreenState extends State<NotesListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('N O T E L Y'),
      ),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: Hive.box<Note>('note').listenable(),
          builder: (context, Box<Note> box, _){
            return ListView.builder(
              reverse: true,
              shrinkWrap: true,
              itemCount: box.length,
                itemBuilder: (context, i)
                {
                  final note = box.getAt(i);

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => ViewNoteScreen(
                                title: note!.title.toString(),
                                description: note!.description.toString(),
                                imageUrl: note!.imagUrl.toString(),
                            ),
                            ));
                          },
                          leading: Image.file(File(
                            note!.imagUrl.toString(),
                          )),
                          title: Text(note!.title.toString()),
                          subtitle: Text(note!.description.toString()),
                          trailing: IconButton( icon: Icon(Icons.delete), onPressed: (){
                            box.delete(i);
                          },),
                        ),
                      ),
                    ),
                  );
                }
                );
          },

        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=> AddNoteScreen(),
          ));
        },
        label: Text('+ | Add Note'),
        

      ),
    );
  }
}
