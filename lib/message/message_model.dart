import 'package:flutter/material.dart';

class MessageModel extends ChangeNotifier {
  String _message = 'No message received';
  String get message => _message;

  void updateMessage(String message) {
    _message = message;
    notifyListeners();
  }
}
