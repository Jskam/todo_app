import 'dart:developer';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/cupertino.dart';

class PomodoroModel extends ChangeNotifier {
  late final CountDownController countDownController = CountDownController();

  bool isPaused = true;
  bool hasStart = false;

  void onPauseAndPlayButton() {
    if (isPaused) {
      if (isPaused && hasStart) {
        countDownController.resume();
        isPaused = false;
      } else {
        countDownController.start();
        isPaused = false;
        hasStart = true;
      }
    } else {
      countDownController.pause();
      isPaused = true;
    }
    notifyListeners();
  }

  void onRestartButton() {
    countDownController.restart();
    countDownController.pause();
    isPaused = true;
    notifyListeners();
  }
}
