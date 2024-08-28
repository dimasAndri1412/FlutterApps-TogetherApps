import 'dart:io';

import 'package:absent_project/MapsViews/MatterialMaps/GmapsController.dart';
import 'package:absent_project/controller/Keys.dart';
import 'package:absent_project/controller/ListAndDetailUserController/UserList.dart';
import 'package:flutter/material.dart';
import 'package:absent_project/attendance/Camera.dart';


class gmapsConfirmHeaders extends StatefulWidget {
  // const gmapsConfirmHeaders({super.key});
  final String imagePath;

  const gmapsConfirmHeaders({super.key, required this.imagePath});
  @override
  State<gmapsConfirmHeaders> createState() => _gmapsConfirmHeadersState();
}

class _gmapsConfirmHeadersState extends State<gmapsConfirmHeaders> {
  // late String avatarURL;

  void findAvatar() async{
    final findAvatarPage = await findAvatarUrl();
    setState(() {
      // avatarURLs = findAvatarPage ?? '';
      clockInImageController.text = widget.imagePath;
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
            // Container(
            //   width: 80,
            //   height: 80,
            //   decoration: BoxDecoration(
            //     border: Border.all(
            //       width: 4,
            //       color: Colors.white
            //     ),
            //     boxShadow: [
            //       BoxShadow(
            //         spreadRadius: 2,
            //         blurRadius: 10,
            //         color: Colors.black26.withOpacity(0.3)
            //       )
            //     ],
            //     shape: BoxShape.circle,
            //     image: DecorationImage(
            //         image: widget.imagePath.isNotEmpty
            //         ? FileImage((File(widget.imagePath)))
            //         : AssetImage("assets/images/reload.png") as ImageProvider,
            //         fit: BoxFit.cover
            //     )
            //   ),
            // ),
          ],
        ),
    );
  }
}
