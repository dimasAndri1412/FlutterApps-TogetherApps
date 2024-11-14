import 'package:absent_project/controller/AbsentController/WeeklyController.dart';
import 'package:absent_project/controller/AbsentController/WeeklyModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class WeeklyBar extends StatefulWidget {
  const WeeklyBar({super.key});

  @override
  State<WeeklyBar> createState() => _WeeklyBarState();
}

class _WeeklyBarState extends State<WeeklyBar> {
  final WeeklyController weeklyController = WeeklyController();
  late Future<List<WeeklyModel>> _weeklyData;
  late TooltipBehavior _tooltip;

  @override
  void initState() {
    super.initState();
    _weeklyData = weeklyController.fetchWeeklyData();
    _tooltip = TooltipBehavior(enable: true); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<WeeklyModel>>(
        future: _weeklyData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Failed to load data'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data available'));
          } else {
            // print('Snapshot data: ${snapshot.data}');

            List<_ChartData> chartData = snapshot.data!.map((weeklyModel) {

              // print('WeeklyModel: ${weeklyModel.day}, ${weeklyModel.totalHours}');

              double totalHours = _parseDurationToHours(weeklyModel.totalHours);
              String formattedDay = _getDayFromDateString(weeklyModel.day);

              // print('Formatted Day: $formattedDay');
              return _ChartData(formattedDay, totalHours);
            }).toList();

            List<String> weekDaysOrder = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
            // chartData.sort((a, b) => weekDaysOrder.indexOf(a.day).compareTo(weekDaysOrder.indexOf(b.day)));

            // print("Ordered chart data:");
            // for (var data in chartData) {
            //   print("${data.day} - ${data.totalHours}");
            // }
            chartData.sort((a, b) => weekDaysOrder.indexOf(a.day).compareTo(weekDaysOrder.indexOf(b.day)));

            //hitung workedHours
            double totalWorkedHours = chartData.fold(0, (sum, item) => sum + item.totalHours);
            int totalHours = totalWorkedHours.toInt();
            int totalMinutes = ((totalWorkedHours - totalHours) * 60).round();
            String formattedTotalWorkedHours = '${totalHours}h ${totalMinutes}m';

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Worked Hours : $formattedTotalWorkedHours",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13
                    ),
                  ),
                  SfCartesianChart(
                    primaryXAxis: CategoryAxis(
                      isInversed: true,
                    ),
                    primaryYAxis: NumericAxis(
                      minimum: 0,
                      maximum: 18,
                      interval: 3,
                      opposedPosition: true,
                    ),
                    tooltipBehavior: _tooltip,
                    series: <CartesianSeries<_ChartData, String>>[
                      BarSeries<_ChartData, String>(
                        dataSource: chartData,
                        xValueMapper: (_ChartData data, _) => data.day, // Hari 
                        yValueMapper: (_ChartData data, _) => data.totalHours, // Total jam 
                        name: 'Total Time',
                        color: Colors.green,
                        dataLabelSettings: DataLabelSettings(
                          isVisible: true,
                          labelAlignment: ChartDataLabelAlignment.outer,
                          builder: (dynamic data, dynamic point, dynamic series, int pointIndex, int seriesIndex) {
                            // Mengonversi jam ke format "18h 00m"
                            int hours = data.totalHours.toInt();
                            int minutes = ((data.totalHours - hours) * 60).toInt();
                            String timeText = '${hours}h ${minutes.toString().padLeft(2, '0')}m';

                            return Text(
                              timeText, 
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12
                              )
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ],
              )
            );
          }
        },
      ),
    );
  }

  double _parseDurationToHours(String duration) {
    var parts = duration.split(':');
    int hours = int.parse(parts[0]);
    int minutes = int.parse(parts[1]);
    int seconds = int.parse(parts[2]);
    return hours + (minutes / 60) + (seconds / 3600);
  }

  String _getDayFromDateString(String dateString) {
    // misahin hari dari waktu 
    var parts = dateString.split(',');
    if (parts.isNotEmpty) {
      String dayName = parts[0].trim();  // get nama hari
      
      return _getShortDayName(dayName);
    }
    return '';
  }

  // ubah nama hari menjadi singkatan (Mon, Tue, dst)
  String _getShortDayName(String dayName) {
    switch(dayName.toLowerCase()) {
      case 'monday': return 'Mon';
      case 'tuesday': return 'Tue';
      case 'wednesday': return 'Wed';
      case 'thursday': return 'Thu';
      case 'friday': return 'Fri';
      case 'saturday': return 'Sat';
      case 'sunday': return 'Sun';
      default: return '';
    }
  }
}

class _ChartData {
  _ChartData(this.day, this.totalHours);
  final String day; 
  final double totalHours;
}
