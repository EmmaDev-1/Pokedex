import 'package:flutter/material.dart';

class VoiceProvider extends ChangeNotifier {
  bool _isVoiceEnabled = true;

  bool get isVoiceEnabled => _isVoiceEnabled;

  void toggleVoice() {
    _isVoiceEnabled = !_isVoiceEnabled;
    notifyListeners();
  }
}
