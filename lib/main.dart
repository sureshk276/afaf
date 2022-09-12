import 'package:firebase_core/firebase_core.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:speechreg/notes/NotesPage.dart';
import 'VoiceScreen/speechScreen.dart';

// void main() {
//   return runApp(const Myapp());
// }
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const Myapp());
}

class Myapp extends StatefulWidget {
  const Myapp({Key? key}) : super(key: key);

  @override
  State<Myapp> createState() => _MyappState();
}

class _MyappState extends State<Myapp> {
  int _currentIndex = 0;
  List<Widget> bodyo = [
    SpeechScreen(),
    const Notepad(),
    const Icon(Icons.settings),
    const Icon(Icons.notification_add)
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Center(
            child: bodyo[_currentIndex],
          ),
          backgroundColor: const Color.fromARGB(255, 36, 12, 78),
          bottomNavigationBar: FloatingNavbar(
            fontSize: 10,
            iconSize: 20,
            backgroundColor: const Color.fromARGB(255, 36, 12, 78),
            currentIndex: _currentIndex,
            items: [
              FloatingNavbarItem(icon: Icons.home, title: 'Home'),
              FloatingNavbarItem(icon: Icons.note, title: 'Notes'),
              FloatingNavbarItem(icon: Icons.search, title: 'Search'),
              FloatingNavbarItem(icon: Icons.settings, title: 'Settings'),
            ],
            onTap: (int newIndex) {
              setState(() {
                _currentIndex = newIndex;
              });
            },
          ),
        ));
  }
}
