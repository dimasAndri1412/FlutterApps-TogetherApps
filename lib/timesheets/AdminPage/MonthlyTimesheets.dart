
import 'package:absent_project/approvalls/lembur/GeneratePDFPage2.dart';
import 'package:absent_project/controller/TimeSheetsController/TimesheetAdmin/ListTimesheetsController.dart';
import 'package:absent_project/controller/TimeSheetsController/TimesheetsUser/MonthlyTimesheetModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:barcode/barcode.dart';
import 'package:printing/printing.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;

import '../../controller/ApprovalController/AdminApprovalOvertime/AdminApprovalOvertimeModel.dart';
class MonthlyTimesheets extends StatelessWidget {

   MonthlyTimesheets({super.key,
   
   });

  Future<Uint8List> generatePdf(String userId, int selectedMonth, int selectedYear) async {
  final pdf = pw.Document();
  ListTimesheetsController listTimesheetsController = ListTimesheetsController();

  try {
    List<MonthlyTimesheetModel> timesheets = await listTimesheetsController.getMonthly(userId, selectedMonth, selectedYear);
    
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
      if (month < 1 || month > 12) {
        return '';
      }

      return monthNames[month - 1];
    }

    pdf.addPage(
      pw.Page(
        pageTheme: pw.PageTheme(
          orientation: pw.PageOrientation.landscape,
          pageFormat: PdfPageFormat.a4.landscape,
        ),
        build: (context) {
          return pw.Container(
            margin: pw.EdgeInsets.all(20),
            child: pw.Column(
              children: [
                pw.Center(
                  child: pw.Text("Timesheet Bulan ${monthToString(selectedMonth)}",
                    style: pw.TextStyle(
                      fontSize: 18,
                      fontWeight: pw.FontWeight.bold
                    )
                  )
                ),
                pw.SizedBox(height: 20),
                pw.Table(
                  border: pw.TableBorder.all(),
                  children: [
                    pw.TableRow(
                      children: [
                        pw.Center(
                          child: pw.Text(
                            'Date', 
                            style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold
                            )
                          ),
                        ),
                        pw.Center(
                          child: pw.Text(
                            'Name of Project', 
                            style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold
                            )
                          ),
                        ),
                        pw.Center(
                          child: pw.Text(
                            'Location', 
                            style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold
                            )
                          ),
                        ),
                        pw.Center(
                          child: pw.Text(
                            'Start', 
                            style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold
                            )
                          ),
                        ),
                        pw.Center(
                          child: pw.Text(
                            'End', 
                            style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold
                            )
                          ),
                        ),
                        pw.Center(
                          child: pw.Text(
                            'Total', 
                            style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold
                            )
                          ),
                        ),
                        pw.Center(
                          child: pw.Text(
                            'Activity / Remark',
                            style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold
                            )
                          ),
                        ),
                      ],
                    ),
                    
                    ...timesheets.map((timesheet) {

                      String answersText = timesheet.answerText != null
                      ? timesheet.answerText!.join("\n")
                      : 'No activity';

                      return pw.TableRow(
                        children: [
                          pw.Padding(
                            padding: pw.EdgeInsets.all(8),
                            child: pw.Text(timesheet.clockIn != null
                              ? '${timesheet.clockIn!.day}-${timesheet.clockIn!.month}-${timesheet.clockIn!.year}'
                              : 'Off'),
                          ),
                          pw.Padding(
                            padding: pw.EdgeInsets.all(8),
                            child: pw.Text(timesheet.grup ?? 'Unknown'),
                          ), 
                          pw.Padding(
                            padding: pw.EdgeInsets.all(8),
                            child:  pw.Text(timesheet.location ?? 'Unknown'),
                          ), 
                          pw.Padding(
                            padding: pw.EdgeInsets.all(8),
                            child: pw.Text(timesheet.clockIn != null
                              ? '${timesheet.clockIn!.hour}:${timesheet.clockIn!.minute}'
                              : 'Off'),
                          ), 
                          pw.Padding(
                            padding: pw.EdgeInsets.all(8),
                            child: pw.Text(timesheet.clockOut != null
                              ? '${timesheet.clockOut!.hour}:${timesheet.clockOut!.minute}'
                              : 'Off'),
                          ), 
                          pw.Padding(
                            padding: pw.EdgeInsets.all(8),
                            child:  pw.Text(timesheet.elapsedTime ?? '0'),
                          ), 
                          pw.Padding(
                            padding: pw.EdgeInsets.all(8),
                            child:  pw.Text(answersText),
                          ), 
                        ],
                      );
                    }).toList(),
                  ],
                )
              ]
            )
          );
        },
      ),
    );

    return await pdf.save();
  } catch (e) {
    print("Error: $e");
    throw Exception("Failed to generate PDF");
  }
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




