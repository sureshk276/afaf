import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/services.dart';

class SpeechScreen extends StatefulWidget {
  SpeechScreen({Key? key}) : super(key: key);

  @override
  State<SpeechScreen> createState() => _SpeechScreenState();
}

class _SpeechScreenState extends State<SpeechScreen> {
  late stt.SpeechToText _speech;
  bool _islistening = false;
  String _text = "Press the button and start to speak";

  void onListen() async {
    if (!_islistening) {
      //print("sgasgag");
      bool avaliable = await _speech.initialize(
          onStatus: (val) => print('onstatus: $val'),
          onError: (val) => print('onError: $val'));
      if (avaliable) {
        setState(() {
          _islistening = true;
        });
        _speech.listen(
            onResult: (val) => setState(() {
                  _text = val.recognizedWords;
                }));
      }
    } else {
      setState(() {
        _islistening = false;
        _speech.stop();
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _speech = stt.SpeechToText();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Speech Notes"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 36, 12, 78),
        elevation: 10,
        toolbarHeight: 70,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        shadowColor: Colors.black,
        actions: [
          Builder(
            builder: (context) => IconButton(
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: _text));
                  Scaffold.of(context).showSnackBar(
                      const SnackBar(content: Text("Copied to clipboard")));
                },
                icon: const Icon(Icons.copy_outlined)),
          )
        ],
      ),
      drawer: Drawer(
        backgroundColor: const Color.fromARGB(255, 36, 12, 78),
        // ignore: prefer_const_literals_to_create_immutables
        child: Column(children: [
          const UserAccountsDrawerHeader(
            decoration: BoxDecoration(
                image: DecorationImage(
                    colorFilter: ColorFilter.mode(
                      const Color.fromARGB(255, 36, 12, 78),
                      BlendMode.color,
                    ),
                    image: AssetImage('assets/images/images.png'))),
            arrowColor: Colors.white,
            accountEmail: null,
            accountName: null,
          ),
        ]),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: AvatarGlow(
        animate: _islistening,
        glowColor: Theme.of(context).primaryColor,
        endRadius: 80,
        duration: const Duration(milliseconds: 2000),
        repeatPauseDuration: const Duration(milliseconds: 100),
        repeat: true,
        child: FloatingActionButton(
            backgroundColor: Color.fromARGB(255, 36, 12, 78),
            onPressed: (() => onListen()),
            child: Icon(
              _islistening ? Icons.mic : Icons.mic_none,
            )),
      ),
      body: SingleChildScrollView(
          reverse: true,
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Container(
                  padding: const EdgeInsets.fromLTRB(30, 30, 20, 30),
                  child: Text(
                    _text,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black54,
                      fontWeight: FontWeight.w400,
                    ),
                  ))
            ],
          )),
    );
  }
}
