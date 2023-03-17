import 'dart:io';

import 'package:flutter/material.dart';

class ViewNoteScreen extends StatelessWidget {
  const ViewNoteScreen({Key? key,
    required this.title,
    required this.description,
    required this.imageUrl})
      : super(key: key);

  final String? title;
  final String? description;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title.toString()),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Text(description.toString(),
            style: TextStyle(fontSize: 30),
            ),
            SizedBox(
              height: 50,
            ),
            Image.file(File(imageUrl!),
            ),
          ],
        ),
      ),
    );
  }
}
