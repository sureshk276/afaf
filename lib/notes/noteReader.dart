import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:speechreg/main.dart';
import 'package:speechreg/notes/NotesPage.dart';
import 'package:speechreg/style/appStyle.dart';
import 'package:speechreg/widget/note_card.dart';

class NoteReader extends StatefulWidget {
  NoteReader(this.doc, {Key? key}) : super(key: key);
  QueryDocumentSnapshot doc;

  @override
  State<NoteReader> createState() => _NoteReaderState();
}

class _NoteReaderState extends State<NoteReader> {
  // ignore: non_constant_identifier_names

  @override
  Widget build(BuildContext context) {
    int color_id = widget.doc['color_id'];
    {
      // ignore: dead_code
      void delete(var id) async {
        await FirebaseFirestore.instance.collection("Notes").doc(id).delete();
      }

      return Scaffold(
        backgroundColor: Appstyle.cardsColor[color_id],
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 36, 12, 78),
          elevation: 0.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          shadowColor: Colors.black,
          actions: [
            Builder(
              builder: (context) => IconButton(
                  onPressed: () async {
                    delete(widget.doc.id);
                    Scaffold.of(context)
                        .showSnackBar(const SnackBar(content: Text("Go Back")));
                  },
                  icon: const Icon(Icons.delete)),
            )
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              widget.doc["Note_Title"],
              style: Appstyle.mainTitle,
            ),
            const SizedBox(
              height: 8.0,
            ),
            Text(
              widget.doc["Create_date"],
              style: Appstyle.dateTitle,
            ),
            const SizedBox(
              height: 28.0,
            ),
            Text(
              widget.doc["Note_Content"],
              style: Appstyle.mainContent,
              //overflow: TextOverflow.ellipsis,
            ),
          ]),
        ),
        // floatingActionButton: FloatingActionButton(
        //     onPressed: () async {
        //       delete(widget.doc.id);
        //     },
        //     child: const Icon(
        //       Icons.delete,
        //     )),
      );
    }
  }
}
