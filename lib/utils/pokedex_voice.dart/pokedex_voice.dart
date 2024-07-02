import 'package:flutter_tts/flutter_tts.dart';

class PokedexVoice {
  final FlutterTts flutterTts = FlutterTts();

  Future<void> speak(String text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(0.65);
    await flutterTts.setSpeechRate(0.55);
    await flutterTts.setVolume(1);
    await flutterTts.speak(text);
  }

  Future<void> stop() async {
    await flutterTts.stop();
  }
}
