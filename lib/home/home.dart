import 'package:absent_project/controller/Keys.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class _ChartData {
  _ChartData(this.x, this.y);
  final String x;
  final double y;
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
    return  CustomScrollView(
      slivers: [
        SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
              children: <Widget>[
                Stack(
                  children: [
                    Container(
                      height: size.height * 0.2 - 30,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(255, 147, 195, 234),
                            Color.fromARGB(255, 98, 171, 232),
                            Color.fromARGB(255, 123, 185, 235),
                          ]
                        ),
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20))  
                      ),
                    ),
                    TextField(
                      decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 30),
                      hintText: "Welcome",
                      hintStyle: TextStyle(color: Colors.white, fontSize: 35),
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      ),
                    ),
                    TextField(
                      controller: emailController,
                      style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 35, top: 46),
                      hintText: emailController.text,
                      hintStyle: TextStyle(color: Colors.white, fontSize: 25),
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  width: 350,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [BoxShadow(
                      color:    Color.fromARGB(255, 147, 195, 234),
                      blurRadius: 15,
                      offset: Offset(5,10),
                  )]
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  width: 350,
                  height: 230,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [BoxShadow(
                      color:    Color.fromARGB(255, 147, 195, 234),
                      blurRadius: 15,
                      offset: Offset(5,10),
                  )]
                  ),
                  child:  SfCartesianChart(
                    primaryXAxis: CategoryAxis(),
                    primaryYAxis: NumericAxis(minimum: 0, maximum: 40, interval: 10),
                    tooltipBehavior: _tooltip,
                    series: <CartesianSeries<_ChartData, String>>[
                      BarSeries<_ChartData, String>(
                          dataSource: data,
                          xValueMapper: (_ChartData data, _) => data.x,
                          yValueMapper: (_ChartData data, _) => data.y,
                          name: 'Gold',
                          color: Color.fromRGBO(8, 142, 255, 1))
                    ]),
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  width: 350,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [BoxShadow(
                      color:    Color.fromARGB(255, 147, 195, 234),
                      blurRadius: 15,
                      offset: Offset(5,10),
                  )]
                  ),
                ),
              ],
            ) 
        )],
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

