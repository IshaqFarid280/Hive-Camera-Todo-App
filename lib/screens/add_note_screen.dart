import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_camera/model/note.dart';
import 'package:image_picker/image_picker.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({Key? key}) : super(key: key);

  @override
  _AddNoteScreenState createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {

  final _formkey = GlobalKey<FormState>();
  XFile? _image;
  String? title;
  String? description;

  getImage() async {
    final image =
        await ImagePicker.platform.pickImage(source: ImageSource.camera);
    setState(() {
      _image = XFile(image!.path);
    });
  }
  submitData()async{
    final isValid = await _formkey.currentState!.validate();

    if(isValid){
      Hive.box<Note>('note').add(Note(title: title, description: description, imagUrl: _image!.path));

      Navigator.of(context).pop();
    }

  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(

      appBar: AppBar(
        title: Text('Add a Note'),
        actions: [
          IconButton(onPressed: submitData, icon: Icon(Icons.save))
        ],
      ),
      body: SafeArea(
        child: Form(
          key: _formkey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    label: Text('Title'),
                  ),
                  autocorrect: false,
                  onChanged: (val) {
                    title = val;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    label: Text('Description'),
                  ),
                  autocorrect: false,
                  minLines: 2,
                  maxLines: 10,
                  onChanged: (val) {
                    title = val;
                  },
                ),
                SizedBox(
                  height: 25,
                ),
                _image == null
                    ? Container()
                    : Image.file(File(_image!.path)),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        child: Icon(Icons.camera),
      ),
    );
  }
}
