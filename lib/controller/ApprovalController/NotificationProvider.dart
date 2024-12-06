import 'package:flutter/material.dart';
import 'notification_model.dart';

class NotificationProvider extends ChangeNotifier {
  final List<NotificationModel> _notifications = [];
  final Set<String> _shownNotifications =
      {}; // Untuk melacak notifikasi yang sudah ditampilkan

  List<NotificationModel> getNotifications() {
    return _notifications;
  }

  void addNotification(String message, String type) {
    // Cek apakah notifikasi sudah pernah ditambahkan
    if (!_shownNotifications.contains(message)) {
      _notifications.add(NotificationModel(message: message, type: type));
      _shownNotifications
          .add(message); // Tandai notifikasi sebagai sudah ditampilkan
      notifyListeners();
    }
  }

  void removeNotification(NotificationModel notification) {
    _notifications.remove(notification);
    notifyListeners();
  }

  void clearShownNotifications() {
    _shownNotifications.clear();
  }
}
