import 'dart:async';
import 'package:absent_project/MapsViews/MatterialMaps/GmapsController.dart';
import 'package:absent_project/controller/Keys.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class gmapsStopWatchController extends GetxController {
  Timer? timer;
  var elapsedTimesModel = '00:00:00'.obs;

  int savedElapsedMilliseconds = 0;
  DateTime? startTime;
  bool isRunning = false;

  @override
  void onInit() {
    super.onInit();
    // loadStopwatchState(); // Memuat status stopwatch saat inisialisasi
  }

  Future<void> startStopwatchFromDatabase(String clockInTime) async {
    startTime = DateTime.parse(clockInTime);
    savedElapsedMilliseconds = DateTime.now().difference(startTime!).inMilliseconds;
    isRunning = true;
    startTimer();
  }

  // Future<void> ClockIinTimes() async {
  //   try {
  //     final findClockInTimesValues = await findClockInTimes(); // Fungsi API
  //     if (findClockInTimesValues != null) {
  //       startTime = DateTime.parse(findClockInTimesValues); // Konversi string ke DateTime
  //       savedElapsedMilliseconds = DateTime.now().difference(startTime!).inMilliseconds;
  //       updateElapsedTime();
  //     }
  //   } catch (e) {
  //     print('Error fetching Clock In time: $e');
  //   }
  // }

  void startStopwatch() async {
    if (isRunning) return;

    startTime = DateTime.now();
    isRunning = true;
    await saveStopwatchState();
    startTimer();
  }

  void stopStopwatch() async {
    if (!isRunning) return;

    savedElapsedMilliseconds += DateTime.now().difference(startTime!).inMilliseconds;
    startTime = null;
    isRunning = false;
    await saveStopwatchState();
    timer?.cancel();
  }

  void resetStopwatch() async {
    savedElapsedMilliseconds = 0;
    startTime = null;
    isRunning = false;
    elapsedTimesModel.value = formatDuration(Duration.zero);
    elapsedTimesController.value.text = elapsedTimesModel.value;
    await clearStopwatchState(); // Pastikan state dihapus dari local storage
    timer?.cancel();
    print("Stopwatch reset and cleared.");
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) => updateElapsedTime());
  }

  void updateElapsedTime() {
    int elapsedMilliseconds = savedElapsedMilliseconds;
    if (startTime != null) {
      elapsedMilliseconds += DateTime.now().difference(startTime!).inMilliseconds;
    }

    elapsedTimesModel.value = formatDuration(Duration(milliseconds: elapsedMilliseconds));
    elapsedTimesController.value.text = elapsedTimesModel.value;
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$hours:$minutes:$seconds';
  }

  Future<void> saveStopwatchState() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('stopwatch_elapsed', savedElapsedMilliseconds);
    prefs.setString('stopwatch_start_time', startTime?.toIso8601String() ?? '');
    prefs.setBool('stopwatch_running', isRunning);
  }

  Future<void> loadStopwatchState() async {
    final prefs = await SharedPreferences.getInstance();

    savedElapsedMilliseconds = prefs.getInt('stopwatch_elapsed') ?? 0;
    isRunning = prefs.getBool('stopwatch_running') ?? false;
    String? startTimeString = prefs.getString('stopwatch_start_time');

    if (startTimeString != null && startTimeString.isNotEmpty) {
      startTime = DateTime.parse(startTimeString);
    }

    if (isRunning) {
      startTimer();
    }

    updateElapsedTime();
  }

  Future<void> clearStopwatchState() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('stopwatch_elapsed');
    prefs.remove('stopwatch_start_time');
    prefs.remove('stopwatch_running');
  }


  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}