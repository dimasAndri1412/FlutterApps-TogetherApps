import 'package:flutter/material.dart';

class TimeEntry extends StatefulWidget {
  const TimeEntry({super.key});

  @override
  State<TimeEntry> createState() => _TimeEntryState();
}

class _TimeEntryState extends State<TimeEntry> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title:Center(
          title: Text(
            "Edit Time Entry",
            style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        // ),
        // automaticallyImplyLeading: false,
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
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child:Column(
          children: [
             Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage('https://w0.peakpx.com/wallpaper/280/151/HD-wallpaper-bts-jungkook-kookie.jpg')
                ),
                SizedBox(width: 20,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Text(
                    "Jeon Jungkook",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                    ),
                  ),
                  Text(
                    "via Android 10",
                    style: TextStyle(
                      fontSize: 12
                    ),
                  ),
                  Text(
                    "SM-G965F | star2lte",
                    style: TextStyle(
                      fontSize: 12
                    ),
                  ),
                ],)
              ],
            ),
            SizedBox(height: 10,),
            Divider(
              color: Colors.grey,
              thickness: 0.5,
            ),
            SizedBox(height: 20,),
            Row(
              children: [
                Icon(Icons.login),
                SizedBox(width: 20,),
                Text("Fri 14 Jun 2024")
              ],
            ),
            SizedBox(height: 20,),
            Row(
              children: [
                Icon(Icons.location_on),
                SizedBox(width: 20,),
                Text("BRI Center Park")
              ],
            ),
            SizedBox(height: 20,),
            Row(
              children: [
                Icon(Icons.label),
                SizedBox(width: 20,),
                Text("Fri 14 Jun 2024")
              ],
            ),
            SizedBox(height: 20,),
            Row(
              children: [
                Icon(Icons.menu),
                SizedBox(width: 20,),
                Text("")
              ],
            ),
            Spacer(),
            Container(
              width: 320,
              height: 40,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.red),
                borderRadius: BorderRadius.circular(6)
              ),
              child: Center(
                child: Text(
                  "Delete Time Entry",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),
            Container(
              width: 320,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(6)
              ),
              child: Center(
                child: Text(
                  "Confirm",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  ),
                ),
              ),
            ),
          ],
        )
      ),
    );
  }
}