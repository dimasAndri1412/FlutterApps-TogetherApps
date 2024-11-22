import 'dart:ui';
import 'package:flutter/material.dart';

class BlurredListTile extends StatelessWidget {
  final bool isLoading;
  final String? data;
  final Widget? trailing;
  final Widget? child;

  const BlurredListTile({
    Key? key,
    required this.isLoading,
    this.data,
    this.trailing,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child ??
            ListTile(
              title: isLoading
                  ? Container(
                color: Colors.grey.withOpacity(0.3),
                height: 16,
                width: double.infinity,
              )
                  : Text(
                data ?? '',
                style: const TextStyle(fontSize: 16),
              ),
              trailing: trailing,
            ),
        if (isLoading)
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: Container(
                color: Colors.transparent,
              ),
            ),
          ),
      ],
    );
  }
}
