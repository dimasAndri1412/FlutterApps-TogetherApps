import 'package:flutter/material.dart';

class AddButtonCustom extends StatelessWidget {
  final String label;
  final Function onPressed;
  final OutlinedBorder shape;
  final Color backgroundColor;
  final Color textColor;

  const AddButtonCustom({
    super.key,
    required this.label,
    required this.onPressed,
    this.shape = const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(5)
      )
    ),
    this.backgroundColor = Colors.blueAccent,
    this.textColor = Colors.white
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        shape: shape,
      ),
        onPressed: () => onPressed(),
        child: Text(
          label,
          style: TextStyle(
            color: textColor,
          ),
        )
    );
  }
}
