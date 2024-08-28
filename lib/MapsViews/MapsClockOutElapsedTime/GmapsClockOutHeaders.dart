import 'dart:io';

import 'package:absent_project/MapsViews/MatterialMaps/GmapsController.dart';
import 'package:absent_project/controller/Keys.dart';
import 'package:flutter/material.dart';


class gmapsClockOutHeader extends StatefulWidget {
  final String imagePath;
  const gmapsClockOutHeader({super.key, required this.imagePath});

  @override
  State<gmapsClockOutHeader> createState() => _gmapsClockOutHeaderState();
}

class _gmapsClockOutHeaderState extends State<gmapsClockOutHeader> {

  void findAvatar() async{
    final findAvatarPage = await findAvatarUrl();
    // setState(() {
    //   avatarURLs = findAvatarPage ?? '';
    // });
    setState(() {
      // avatarURLs = findAvatarPage ?? '';
      clockOutImageController.text = widget.imagePath;
    });
  }

  @override
  void initState() {
    super.initState();
    findAvatar();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 10),
        child: Stack(
          children: [
            Container(
              child: ClipOval(
                child: Image(
                  image: widget.imagePath.isNotEmpty
                    ? FileImage(File(widget.imagePath))
                    : AssetImage("assets/images/reload.png") as ImageProvider,
                  fit: BoxFit.cover,
                  width: 80,  // Tentukan ukuran width sesuai kebutuhan
                  height: 80, // Tentukan ukuran height sesuai kebutuhan
                ),
              )
            )
          ],
        ),
    );
  }
}
