import 'package:flutter/foundation.dart';

class ClockInState with ChangeNotifier {
  bool _hasClockedIn = false;

  bool get hasClockedIn => _hasClockedIn;

  void clockIn() {
    _hasClockedIn = true;
    notifyListeners();
  }

  void clockOut() {
    _hasClockedIn = false;
    notifyListeners();
  }
}
