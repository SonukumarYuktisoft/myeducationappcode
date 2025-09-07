import 'dart:async';
import 'dart:math';
import 'package:get/get.dart';

class LoadingController extends GetxController {
  final RxString currentText = "Loading...".obs;

  final List<String> loadingTexts = [
    "Loading...",
    "Please wait...",
    "Fetching data...",
    "Processing...",
    "Just a moment...",
    "Working on it...",
    "Almost done...",
    "Hang tight...",
    "Preparing...",
    "Getting things ready..."
  ].obs;

  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(milliseconds: 2000), (_) {
      final random = Random();
      currentText.value = loadingTexts[random.nextInt(loadingTexts.length)];
    });
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
