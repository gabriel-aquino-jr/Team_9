import 'package:flutter/material.dart';

class ButtonTapListenerClass extends ChangeNotifier {
  bool isClicked = false;

  void clickEvent() {
    isClicked = !isClicked;
    notifyListeners();
  }
}
