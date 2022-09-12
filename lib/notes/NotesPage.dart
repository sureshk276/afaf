import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speechreg/notes/noteEditor.dart';
import 'package:speechreg/notes/noteReader.dart';
import 'package:speechreg/style/appStyle.dart';
import 'package:speechreg/widget/note_card.dart';

class Notepad extends StatefulWidget {
  const Notepad({Key? key}) : super(key: key);

  @override
  State<Notepad> createState() => _NotepadState();
}

class _NotepadState extends State<Notepad> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, //Appstyle.mainColor,
      appBar: AppBar(
        title: const Text("Notes"),
        centerTitle: true,
        backgroundColor: Appstyle.mainColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        shadowColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection("Notes").snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasData) {
                    return GridView(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                      children: snapshot.data!.docs
                          .map((note) => noteCard(() {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => NoteReader(note),
                                    ));
                              }, note))
                          .toList(),
                    );
                  }
                  return Text(
                    "There is no Notes",
                    style: GoogleFonts.nunito(color: Colors.white),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Color.fromARGB(255, 36, 12, 78),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => NoteEditor()));
        },
        label: Text("Add Notes"),
        icon: Icon(Icons.add),
      ),
    );
  }
}
