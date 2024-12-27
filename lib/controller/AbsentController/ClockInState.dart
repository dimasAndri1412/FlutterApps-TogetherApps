import 'package:absent_project/MapsViews/MatterialMaps/GmapsController.dart';
import 'package:absent_project/MapsViews/MatterialMaps/GmapsStopWatchController.dart';
import 'package:absent_project/controller/Keys.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class ClockInState with ChangeNotifier {
  bool _hasClockedIn = false;

  bool get hasClockedIn => _hasClockedIn;

  final stopWatchControll = Get.put(gmapsStopWatchController());

  ClockInState() {
    checkClockInStatusAndLoad();
  }

  Future<void> checkClockInStatusAndLoad() async {
    try {
      final clockInTime = await findClockInTimes();
      final isClockIn = await secureStorage.read(key: 'isClockIn') == 'true';
      if (clockInTime != null && isClockIn) {
        _hasClockedIn = true;
        stopWatchControll.startStopwatchFromDatabase(clockInTime);
      } else {
        _hasClockedIn = false;
        stopWatchControll.resetStopwatch();
      }
      notifyListeners();
    } catch (e) {
      debugPrint('Error saat memuat status Clock-In: $e');
    }
  }

  Future<void> saveClockInStatus() async {
    try {
      await secureStorage.write(key: 'isClockIn', value: 'true');
      _hasClockedIn = true;
      notifyListeners();
    } catch (e) {
      debugPrint('Error saat menyimpan status Clock-In: \$e');
    }
  }

  void clockIn() {
    saveClockInStatus();
    stopWatchControll.startStopwatch();
    notifyListeners();
  }

  Future<void> clockOut() async {
    try {
      await secureStorage.write(key: 'isClockIn', value: 'false');
      _hasClockedIn = false;
      stopWatchControll.resetStopwatch(); // Reset stopwatch
      notifyListeners();
      print("Clock Out state saved and stopwatch reset.");
    } catch (e) {
      debugPrint('Error saat menyimpan status Clock-Out: $e');
    }
  }
}