import 'package:absent_project/MapsViews/MatterialMaps/GmapsController.dart';
import 'package:absent_project/controller/Keys.dart';
import 'package:flutter/material.dart';

class gmapsClockOutHeader extends StatefulWidget {
  const gmapsClockOutHeader({super.key});

  @override
  State<gmapsClockOutHeader> createState() => _gmapsClockOutHeaderState();
}

class _gmapsClockOutHeaderState extends State<gmapsClockOutHeader> {

  void findAvatar() async{
    final findAvatarPage = await findAvatarUrl();
    setState(() {
      avatarURLs = findAvatarPage ?? '';
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
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 4,
                        color: Colors.white
                      ),
                      boxShadow: [
                        BoxShadow(
                          spreadRadius: 2,
                          blurRadius: 10,
                          color: Colors.black26.withOpacity(0.3)
                        )
                      ],
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: avatarURLs.isNotEmpty
                              ? NetworkImage(avatarURLs)
                              : AssetImage("assets/images/reload.png") as ImageProvider,
                        fit: BoxFit.cover
                      )
                    ),
                  )
                ],
              ),
            )
          ],
        ),
    );
  }
}
