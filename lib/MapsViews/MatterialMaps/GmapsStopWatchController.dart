import 'dart:async';
import 'package:absent_project/controller/Keys.dart';
import 'package:get/get.dart';

class gmapsStopWatchController extends GetxController {

  late Stopwatch stopwatch;
  late Timer timer;
  var elapsedTimesModel = '00:00:00'.obs;

  @override
  void onInit() {
    super.onInit();
    stopwatch = Stopwatch();
    timer = Timer(Duration.zero, () {});
  }

  @override
  void onClose() {
    super.onClose();
    if (timer.isActive) {
      timer.cancel();
    }
  }

  void startStopwatch() {
    stopwatch.start();
    timer = Timer.periodic(Duration(seconds: 1), updateElapsedTime);
  }

  void stopStopwatch() {
    stopwatch.stop();
    if(timer.isActive) {
      print("stopwatch is stoped");
      timer.cancel();
    }
    elapsedTimesModel.value = formatDuration(stopwatch.elapsed);
  }

  void resetStopwatch() {
    stopwatch.reset();
    elapsedTimesModel.value = formatDuration(Duration.zero);
    elapsedTimesController.text = elapsedTimesModel.value;
  }

  void updateElapsedTime(Timer? timer) {
    final duration = stopwatch.elapsed;
    elapsedTimesModel.value = formatDuration(duration);
    elapsedTimesController.text = elapsedTimesModel.value;
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$hours:$minutes:$seconds';
  }
}