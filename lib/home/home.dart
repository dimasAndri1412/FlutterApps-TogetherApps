import 'package:absent_project/home/WeeklyBar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../controller/Keys.dart';

class _ChartData {
  _ChartData(this.x, this.y);
  final String x;
  final double y;
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  late List<_ChartData> data;
  late TooltipBehavior _tooltip;

  void initState() {
    data = [
      _ChartData('CHN', 12),
      _ChartData('GER', 15),
      _ChartData('RUS', 30),
      _ChartData('BRZ', 6.4),
      _ChartData('IND', 14)
    ];
    _tooltip = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Stack(
                  children: [
                    Container(
                      height: size.height * 0.2 - 20,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            Color.fromARGB(255, 147, 195, 234),
                            Color.fromARGB(255, 98, 171, 232),
                            Color.fromARGB(255, 123, 185, 235),
                          ]),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20))),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20, bottom: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start, 
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Welcome",
                            style: TextStyle(color: Colors.white, fontSize: 35, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            emailController.text,
                            style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "as ${positioNamesControllers.text}",
                            style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "in ${projectNamesControllers.text} project",
                            style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ],
                      )
                    )
                  ],
                ),
                SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 35),
                      child: Text(
                        "Today's Status",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: Colors.grey[600]),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: 5, bottom: 10, left: 30, right: 30),
                      // width: 350,
                      // height: 150,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(255, 147, 195, 234),
                              blurRadius: 15,
                              offset: Offset(5, 10),
                            )
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 25, left: 20, right: 20, bottom: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Time Clock",
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 15)),
                            SizedBox(height: 15),
                            Row(children: [
                              Icon(
                                Icons.login,
                                color: Colors.green[600],
                                size: 30,
                              ),
                              SizedBox(width: 20),
                              Expanded(
                                  child: TextFormField(
                                    controller: elapsedTimesController.value,
                                    readOnly: true,
                                    decoration: InputDecoration(
                                      hintText: "00:00:00",
                                      hintStyle: TextStyle(
                                          color: Colors.black26,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 30
                                      ),
                                      border: InputBorder.none,
                                    ),
                                    style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                              )
                            ]),
                            Divider(),
                            Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: TextFormField(
                                  controller: shiftLocationFieldController,
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    labelText: "To day's Schedule",
                                    labelStyle: TextStyle(
                                        color: Colors.black38,
                                        fontSize: 20
                                    ),
                                    hintText: "Your's Activity",
                                    hintStyle: TextStyle(
                                        fontSize: 13
                                    ),
                                    border: InputBorder.none,
                                  ),
                                )
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: 10, bottom: 10, left: 30, right: 30),
                      // width: 350,
                      height: 380,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(255, 147, 195, 234),
                              blurRadius: 15,
                              offset: Offset(5, 10),
                            )
                          ]),
                      child: ClipRRect(  
                          borderRadius: BorderRadius.circular(20),
                          child: WeeklyBar(),  
                        ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: 20, bottom: 20, left: 30, right: 30),
                      width: 350,
                      height: 150,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(255, 147, 195, 234),
                              blurRadius: 15,
                              offset: Offset(5, 10),
                            )
                          ]),
                    ),
                  ],
                ),
              ],
            ))
      ],
    );
    // Scaffold(
    //   body: Container(
    //     child: Container(
    //       height: 230,
    //       decoration: BoxDecoration(
    //       color: Colors.pink[200],
    //       borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50), bottomRight: Radius.circular(50))
    //       ),
    //     ),
    //   ),
    // );
  }
}
