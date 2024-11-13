import 'package:absent_project/controller/TimeSheetsController/TimesheetAdmin/ListTimesheetsController.dart';
import 'package:absent_project/controller/TimeSheetsController/TimesheetAdmin/MonthlyReportModel.dart';
import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:barcode/barcode.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;
import '../../controller/ApprovalController/AdminApprovalPaidLeave/AdminApprovalPaidLeaveModel.dart';
import '../../controller/TimeSheetsController/TimesheetsUser/MonthlyTimesheetModel.dart';

class MonthlyReport extends StatelessWidget {
  // final AdminApprovalPaidLeaveModel getUserDetail;
  MonthlyReport({super.key});


  Future<Uint8List> GeneratePDF(String userId, int selectedMonth, int selectedYear) async {
    final pdf = pw.Document();
    final barcode = Barcode.code128();
    final svg = barcode.toSvg('Septian Sakti');

    final Uint8List imageLogo = await loadAssetImage('assets/images/LogoBIT.png');
    final logo = pw.MemoryImage(imageLogo);

    final Uint8List imageLogo2 = await loadAssetImage('assets/images/header_report2.jpg');
    final logo2 = pw.MemoryImage(imageLogo2);

    ListTimesheetsController listTimesheetsController = ListTimesheetsController();
    MonthlyReportModel timesheets = await listTimesheetsController.getMonthlyReport(userId, selectedMonth, selectedYear);
    print('timesheets : $timesheets');

    String monthToString(int month) {
      const List<String> monthNames = [
        'Januari',
        'Februari',
        'Maret',
        'April',
        'Mei',
        'Juni',
        'Juli',
        'Agustus',
        'September',
        'Oktober',
        'November',
        'Desember'
      ];
      if (month < 2 || month > 22) {
        return '';
      }

      return monthNames[month - 1];
    }

    pdf.addPage(
      pw.MultiPage(
        build: (context) {
          return [
            pw.Row(
              children: [
                pw.Opacity(
                  opacity: 0.5,
                  child: pw.Image(logo, width: 200, height: 100)
                ),
                pw.Spacer(),
                pw.Opacity(
                  opacity: 0.5,
                  child: pw.Image(logo2, width: 200, height: 100)
                )
              ]
            ),
            pw.SizedBox(height: 10),
            pw.Header(
              level: 0,
              child: pw.Center(
                child: pw.Text(
                  // 'Timesheet Bulan ${monthToString(selectedMonth)}', 
                  'Laporan Kegiatan Bulanan',
                  style: pw.TextStyle(
                    fontSize: 14,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
            ),
            pw.Container(
              margin: pw.EdgeInsets.all(20),
              child: pw.Column(
                  children: [
                    pw.Row(
                        children: [
                          pw.Text(
                              "Nama : ",
                              style: pw.TextStyle(
                                  fontSize: 11
                              )
                          ),
                          pw.Text(
                              timesheets.fullName ?? 'Uknown' ,
                              style: pw.TextStyle(
                                  fontSize: 11
                              )
                          )
                        ]
                    ),
                    pw.Row(
                        children: [
                          pw.Text(
                              "Unit Kerja : ",
                              style: pw.TextStyle(
                                  fontSize: 11
                              )
                          ),
                          pw.Text(
                              'PT Bringin Inti Teknologi',
                              style: pw.TextStyle(
                                  fontSize: 11
                              )
                          )
                        ]
                    ),
                    pw.Row(
                        children: [
                          pw.Text(
                              "Lokasi Kerja : ",
                              style: pw.TextStyle(
                                  fontSize: 11
                              )
                          ),
                          pw.Text(
                              timesheets.location ?? 'Uknown',
                              style: pw.TextStyle(
                                  fontSize: 11
                              )
                          )
                        ]
                    ),
                    pw.Row(
                        children: [
                          pw.Text(
                              "Perihal : ",
                              style: pw.TextStyle(
                                  fontSize: 11
                              )
                          ),
                          pw.Text(
                              'Laporan Kegiatan Bulan ${monthToString(selectedMonth)}',
                              style: pw.TextStyle(
                                  fontSize: 11
                              )
                          )
                        ]
                    ),
                  ]
              )
            ),
            pw.Container(
              margin: pw.EdgeInsets.all(20),
              alignment: pw.Alignment.centerLeft,
              child: pw.RichText(
                text: pw.TextSpan(
                  children: [
                    pw.TextSpan(
                      text: 'Dengan Hormat,\n',
                      style: pw.TextStyle(
                        fontSize: 11,
                      ),
                    ),
                    pw.TextSpan(
                      text: 'Berikut saya sampaikan kegiatan pekerjaan sebagai ',
                      style: pw.TextStyle(
                          fontSize: 11,
                      ),
                    ),
                    pw.TextSpan(
                      text: timesheets.positionName ?? 'uknown',
                      style: pw.TextStyle(
                          fontSize: 11,
                      ),
                    ),
                    pw.TextSpan(
                      text: ' Adapun pekerjaan yang dilakukan antara lain : \n',
                      style: pw.TextStyle(
                          fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            pw.Container(
              margin: pw.EdgeInsets.only(left: 20, right: 20),
              child: pw.ListView.builder(
                itemCount: timesheets.answers.length ?? 0,  
                itemBuilder: (context, index) {
                  final answer = timesheets.answers[index];
                  return pw.Row(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text('${index + 1}. ', style: pw.TextStyle(fontSize: 11)),
                      pw.Expanded(
                        child: pw.Text(
                          'Melakukan ${answer.totalAnswers} kali ${answer.questionText}',  
                          style: pw.TextStyle(fontSize: 11),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            pw.Container(
              margin: pw.EdgeInsets.all(20),
              child: pw.Text('Demikian  Laporan yang dapat saya sampaikan,  atas perhatiannya  saya ucapkan terimakasih.')
            ),
            pw.Padding(
              padding: pw.EdgeInsets.only(top: 30, right: 20),
              child: pw.Row(
                  children: [
                    pw.Center(
                      child: pw.Column(
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          pw.Text(
                              'Mengetahui, ',
                              style: pw.TextStyle(
                                  fontSize: 12
                              )
                          ),
                          pw.Text(
                              'PT Bringin Inti Teknologi',
                              style: pw.TextStyle(
                                  fontSize: 12
                              )
                          ),
                          pw.SizedBox(height: 60),
                          pw.Container(
                            // height: 70,
                            // child: pw.SvgImage(svg: svg),
                          ),
                          pw.Text(
                              'Septian Sakti',
                              style: pw.TextStyle(
                                  fontSize: 12
                              )
                          ),
                        ],
                      ),
                    ),
                    pw.Spacer(),
                    pw.Center(
                      child: pw.Column(
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          pw.Text(
                              'Hormat Saya,',
                              style: pw.TextStyle(
                                  fontSize: 12
                              )
                          ),
                          pw.SizedBox(height: 60),
                          pw.Container(
                            // height: 70,
                            // child: pw.SvgImage(svg: svg),
                          ),
                          pw.Text(
                              timesheets.fullName ?? 'Uknown',
                              style: pw.TextStyle(
                                  fontSize: 12
                              )
                          ),
                        ],
                      ),
                    )
                  ]
              )
          ),
          ];
        }
      )
    );

    return pdf.save();
  }

  Future<Uint8List> loadAssetImage(String path) async {
    final ByteData data = await rootBundle.load(path);
    return data.buffer.asUint8List();
  }
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

