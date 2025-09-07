import 'package:flutter/foundation.dart';
import 'dart:async';

class BaseDebouncer {
  final int? milliSeconds;
  Timer? timer;

  BaseDebouncer({this.timer, this.milliSeconds});

  run(VoidCallback action) {
    timer?.cancel();
    timer = Timer(Duration(milliseconds: milliSeconds??800), action);
  }
}