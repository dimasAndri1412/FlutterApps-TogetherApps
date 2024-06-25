import 'dart:ffi';

import 'package:flutter/material.dart';

class DailyTimesheets extends StatefulWidget {
  const DailyTimesheets({super.key});

  @override
  State<DailyTimesheets> createState() => _DailyTimesheetsState();
}

class _DailyTimesheetsState extends State<DailyTimesheets> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Center(
          child: Text(
            "Daily Timesheets",
            style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        automaticallyImplyLeading: false,
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
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 20, bottom: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  margin: EdgeInsets.all(10),
                  height: 50,
                  width: 350,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 0,
                        blurRadius: 1,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Icon(Icons.info),
                        SizedBox(width: 10,),
                        Text('Only scheduled hours are included')
                      ],
                    ),
                  )
                ),
              ),
              SizedBox(height: 10,),
              Container(
                margin: EdgeInsets.all(10),
                child: Text(
                  'Tue, 25 Jun',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Container(
                height: 300,
                decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 0,
                    blurRadius: 2,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage('https://w0.peakpx.com/wallpaper/280/151/HD-wallpaper-bts-jungkook-kookie.jpg')
                          ),
                          SizedBox(width: 10,),
                          Center(
                            child: Text(
                              "Jeon Jungkook",
                              style: TextStyle(
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.grey,
                      thickness: 0.5,
                      // indent: 2,
                      // endIndent: 2,
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Text(
                        'Tracked Time',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                     Container(
                      margin: EdgeInsets.only(left: 20, right: 20, bottom: 5),
                      child: Row(
                        children: [
                          Text('First in',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                              fontWeight: FontWeight.normal
                            ),
                          ),
                          SizedBox(width: 150,),
                          Text('Last Out',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                              fontWeight: FontWeight.normal
                            ),
                          )
                        ],
                      )
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20, right: 20, top: 2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('7:28',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          SizedBox(width: 160,),
                          Text('-',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold
                            ),
                          )
                        ],
                      )
                    ),
                    SizedBox(height: 10,),
                    Container(
                      margin: EdgeInsets.only(left: 20, right: 20, bottom: 5),
                      child: Row(
                        children: [
                          Text('Breaks',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                              fontWeight: FontWeight.normal
                            ),
                          ),
                          SizedBox(width: 150,),
                          Text('Worked Hours',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                              fontWeight: FontWeight.normal
                            ),
                          )
                        ],
                      )
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20, right: 20, top: 2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('0h 00m',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          SizedBox(width: 140,),
                          Text('7h 41m',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold
                            ),
                          )
                        ],
                      )
                    ),
                    Spacer(),
                    Center(
                      child: IconButton(
                        icon: const Icon(Icons.arrow_drop_down, size: 30),
                        onPressed: () {},
                      ),
                    )
                  ],
                )
              )
            ],
          )
        )
      )
    );
  }
}