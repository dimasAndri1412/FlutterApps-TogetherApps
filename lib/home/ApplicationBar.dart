import 'package:flutter/material.dart';
import 'package:absent_project/home/Home.dart';
import 'package:absent_project/menu/MenuPage.dart';

class ApplicationBar extends StatefulWidget {
  const ApplicationBar({super.key});

  @override
  State<ApplicationBar> createState() => _ApplicationBarState();
}

class _ApplicationBarState extends State<ApplicationBar> {

  int currentIndex = 0;
  List<Widget> body = const [
    Home(),
    Icon(Icons.lock_clock),
    MenuPage()
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 147, 195, 234),
                    Color.fromARGB(255, 98, 171, 232),
                    Color.fromARGB(255, 123, 185, 235),
                  ]
                ),
          ),
        ),
        elevation: 0,
        // leading: IconButton(
        //     onPressed: (){},
        //     icon: Icon(Icons.menu),
        //   ),
      ),
      body: Center(
        child: body[currentIndex],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (int newIndex) {
            setState(() {
              currentIndex = newIndex;
            });
          },
          items: const [
            BottomNavigationBarItem(
              label: "Home",
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              label: "Time Clock",
              icon: Icon(Icons.lock_clock),
            ),
            BottomNavigationBarItem(
              label: "Menu",
              icon: Icon(Icons.menu),
            )
          ],
        ),
    );
  }
}
