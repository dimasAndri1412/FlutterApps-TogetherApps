import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:app_set_id/app_set_id.dart';
import 'package:flutter/services.dart';

class Getdevice {
  final _appsetIdPlugin = AppSetId();

  Future<String> getDeviceId() async {
    String identifier;
    try {
      identifier = await _appsetIdPlugin.getIdentifier() ?? "Unknown";
    } on PlatformException {
      identifier = 'Failed to get identifier.';
    }
    return identifier;
  }
}
