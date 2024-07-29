import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ImageWithFaces extends StatelessWidget {
  final XFile imageFile;
  final List<Face> faces;

  ImageWithFaces({required this.imageFile, required this.faces});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.file(
            File(imageFile.path),
            fit: BoxFit.cover,
          ),
          CustomPaint(
            painter: FacePainter(faces: faces, imageSize: Size(500, 500)),
          ),
        ],
      ),
    );
  }
}

class FacePainter extends CustomPainter {
  final List<Face> faces;
  final Size imageSize;

  FacePainter({required this.faces, required this.imageSize});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;

    for (Face face in faces) {
      final Rect boundingBox = face.boundingBox;
      final Rect rect = Rect.fromLTWH(
        boundingBox.left * size.width / imageSize.width,
        boundingBox.top * size.height / imageSize.height,
        boundingBox.width * size.width / imageSize.width,
        boundingBox.height * size.height / imageSize.height,
      );

      canvas.drawRect(rect, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
