import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../style/appStyle.dart';

class NoteEditor extends StatefulWidget {
  NoteEditor({Key? key}) : super(key: key);

  @override
  State<NoteEditor> createState() => _NoteEditorState();
}

class _NoteEditorState extends State<NoteEditor> {
  int color_id = Random().nextInt(Appstyle.cardsColor.length);
  String date = DateTime.now().toString();
  TextEditingController _titleControler = TextEditingController();
  TextEditingController _mainControler = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appstyle.cardsColor[color_id],
      appBar: AppBar(
        backgroundColor: Appstyle.mainColor,
        elevation: 0.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        shadowColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Add a New Notes",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          TextField(
            controller: _titleControler,
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: "Note Title",
            ),
            style: Appstyle.mainTitle,
          ),
          const SizedBox(
            height: 8.0,
          ),
          Text(
            date,
            style: Appstyle.dateTitle,
          ),
          const SizedBox(
            height: 28.0,
          ),
          TextField(
            controller: _mainControler,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: "Note Content",
            ),
            style: Appstyle.mainContent,
          ),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Appstyle.accent,
          onPressed: () {
            FirebaseFirestore.instance.collection("Notes").add({
              "Note_Title": _titleControler.text,
              "Create_date": date,
              "Note_Content": _mainControler.text,
              "color_id": color_id,
            }).then((value) {
              print(value.id);
              Navigator.pop(context);
            }).catchError(
                (error) => print("Failed to add the Notes due to $error"));
          },
          child: const Icon(
            Icons.save,
          )),
    );
  }
}
