import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';


String _lastWords = '';
class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);
  @override
  _TestState createState() => _TestState();
}



class _TestState extends State<Test> {
  SpeechToText _speechToText = SpeechToText();
  FlutterTts flutterTts = FlutterTts();
  bool _speechEnabled = false;
  bool listening = false;

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  /// This has to happen only once per app
  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }



  Future<String> _startListening() async {
    await _speechToText.listen(
      onResult:(result){
        setState(() {
          _lastWords = result.recognizedWords;
        });
      },
    );
    print("knvldfvjfxjvkxdgflvj");
    setState(() {listening=false;});

    return _lastWords;



  }

  void _stopListening() async {
    await _speechToText.stop();
    //setState(() {});
    print("************** STOP ************");

    // if(_lastWords =="Merhaba"){
    //   await speak("Merhabalar. İsmini öğrenebilir miyim");
    //   var isim = _startListening();
    //   await speak("Memnun oldum ${isim}");
    //
    // }
  }


  Future speak(String text) async{
    await flutterTts.speak(text);
  }

  Future startt()async{
    listening ? _stopListening() : await _startListening().then((value){
      if(_lastWords =="Merhaba"){
        speak("Merhaba. İsminizi Öğrenebilir miyim.");
      }
      print("Çaliştiiii");
    });

    if(_speechToText.isNotListening){
      print("Sonuççç == ${_lastWords}");
    }


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Speech Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(16),
              child: Text(
                'Recognized words:${_lastWords}',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(16),
                child: Text(
                  _speechToText.isListening? '$_lastWords': _speechEnabled? 'Tap the microphone to start listening...': 'Speech not available',
                ),
              ),
            ),

            IconButton(
              onPressed: startt,
              icon: Icon(_speechToText.isNotListening ? Icons.mic_off : Icons.mic),)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:startt,



        tooltip: 'Listen',
        child: Icon(_speechToText.isNotListening ? Icons.mic_off : Icons.mic),
      ),
    );
  }
}


