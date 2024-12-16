
import 'package:absent_project/approvalls/lembur/GeneratePDFPage2.dart';
import 'package:absent_project/controller/Keys.dart';
import 'package:absent_project/controller/TimeSheetsController/TimesheetAdmin/ListTimesheetsController.dart';
import 'package:absent_project/controller/TimeSheetsController/TimesheetsUser/MonthlyTimesheetModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
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
    print('timesheets : $timesheets');

    final lastDayOfMonth = DateTime(selectedYear, selectedMonth + 1, 0).day;
    final List<DateTime> dates = List.generate(
      lastDayOfMonth,
      (index) => DateTime(selectedYear, selectedMonth, index + 1),
    );
    final lastDate = DateTime(selectedYear, selectedMonth + 1, 0); // Tanggal terakhir bulan
    final formattedDate = DateFormat('dd MMM yyyy').format(lastDate);

    String fullName = await listTimesheetsController.getFullName(userId);
    
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
            pw.Header(
              level: 0,
              child: pw.Center(
                child: pw.Text(
                  'Timesheet Bulan ${monthToString(selectedMonth)}', 
                  style: pw.TextStyle(
                    fontSize: 16,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
            ),
            pw.Table(
              border: pw.TableBorder.all(),
              children: [
                // Header row
                pw.TableRow(
                  children: [
                    pw.Container(
                      width: 80,
                      height: 30,
                      alignment: pw.Alignment.center,
                      color: PdfColors.red200,
                      child: pw.Text(
                        'Date', 
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                      ),
                    ),
                    pw.Container(
                      height: 30,
                      alignment: pw.Alignment.center,
                      color: PdfColors.red200,
                      child: pw.Text(
                        'Name of Project', 
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                      ),
                    ),
                    pw.Container(
                      height: 30,
                      alignment: pw.Alignment.center,
                      color: PdfColors.red200,
                      child: pw.Text(
                        'Location', 
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                      ),
                    ),
                    pw.Container(
                      width: 50,
                      height: 30,
                      alignment: pw.Alignment.center,
                      color: PdfColors.red200,
                      child: pw.Text(
                        'Start', 
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                      ),
                    ),
                    pw.Container(
                      width: 50,
                      height: 30,
                      alignment: pw.Alignment.center,
                      color: PdfColors.red200,
                      child: pw.Text(
                        'End', 
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                      ),
                    ),
                    pw.Container(
                      width: 70,
                      height: 30,
                      alignment: pw.Alignment.center,
                      color: PdfColors.red200,
                      child: pw.Text(
                        'Total', 
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                      ),
                    ),
                    pw.Container(
                      height: 30,
                      alignment: pw.Alignment.center,
                      color: PdfColors.red200,
                      child: pw.Text(
                        'Activity / Remark',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                // Data rows
                ...dates.map((date) {
                  final timesheet = timesheets.firstWhere(
                    (item) => item.clockIn != null && item.clockIn!.day == date.day,
                    orElse: () => MonthlyTimesheetModel(
                      clockIn: null,
                      location: 'Off',
                      shift: 'Off',
                      clockOut: null,
                      clockOutId: 'Off',
                      elapsedTime: 'Off',
                      questionText: [],
                      answerText: ['Off'],
                      grup: 'Off',
                      overtime: null,
                      paidLeaveDate: null,
                      paidLeaveActivity: null
                    ),
                  );
                  // print("timesheet: ${timesheets}"); 
                  
                  final sickEntry = timesheets.firstWhere(
                    (item) {
                      if (item.sickDate != null && item.sickDate!.isNotEmpty) {
                        try {
                          DateTime dateSick = DateTime.parse(item.sickDate!);
                          return dateSick.year == date.year && dateSick.month == date.month && dateSick.day == date.day;
                        } catch (e) {
                          print("Error parsing sickNote: ${item.sickDate}");
                          return false;  
                        }
                      }
                      return false;  
                    },
                    orElse: () => MonthlyTimesheetModel(
                      clockIn: null,
                      location: 'Off',
                      shift: 'Off',
                      clockOut: null,
                      clockOutId: 'Off',
                      elapsedTime: 'Off',
                      questionText: [],
                      answerText: ['Off'],
                      grup: 'Off',
                      overtime: null,
                      sickNote: null,
                      sickDate: null,
                    ),

                  );

                  final paidLeaveEntry = timesheets.firstWhere(
                    (item) {
                      if (item.type == "paid_leave" && item.paidLeaveDate != null && item.paidLeaveDate!.isNotEmpty) {
                        try {
                          DateTime dateLeave = DateTime.parse(item.paidLeaveDate!);
                          return dateLeave.year == date.year &&
                                dateLeave.month == date.month &&
                                dateLeave.day == date.day;
                        } catch (e) {
                          print("Error parsing leaveDate: ${item.paidLeaveDate}");
                          return false;
                        }
                      }
                      return false;
                    },
                    orElse: () => MonthlyTimesheetModel(
                      clockIn: null,
                      location: 'Off',
                      shift: 'Off',
                      clockOut: null,
                      clockOutId: 'Off',
                      elapsedTime: 'Off',
                      questionText: [],
                      answerText: ['Off'],
                      grup: 'Off',
                      overtime: null,
                      paidLeaveDate: null,
                      paidLeaveActivity: null,
                      paidLeaveStatus: null,
                      type: null,
                    ),
                  );
                  
                  final overtimeData = timesheet.overtime;
                  final isSickDay = sickEntry.sickDate != null && sickEntry.sickDate == date.toIso8601String().split('T').first;
                  final isPaidLeave = paidLeaveEntry.paidLeaveDate != null && paidLeaveEntry.paidLeaveDate == date.toIso8601String().split('T').first;
                  final isDataAvailable = timesheet.clockIn != null;
                  // print('isPaidLeave: $isPaidLeave');
                  

                  List<pw.TableRow> rows = [
                    pw.TableRow(
                      children: [
                        pw.Container(
                          alignment: pw.Alignment.center,
                          color: 
                          isPaidLeave
                          ? PdfColors.pink
                          : isSickDay 
                          ? PdfColors.blue 
                          : (isDataAvailable ? PdfColors.white : PdfColors.yellow),
                          child: pw.Text(
                            '${date.day}-${date.month}-${date.year}',
                            style: pw.TextStyle(fontSize: 11),
                          ),
                        ),
                        pw.Container(
                          alignment: pw.Alignment.center,
                          color: isPaidLeave
                          ? PdfColors.pink
                          : isSickDay ? PdfColors.blue : (isDataAvailable ? PdfColors.white : PdfColors.yellow),
                          child: pw.Text(
                            isDataAvailable ? timesheet.grup ?? 'Unknown' : 'Off',
                            style: pw.TextStyle(fontSize: 11),
                          ),
                        ),
                        pw.Container(
                          alignment: pw.Alignment.center,
                          color: isPaidLeave
                          ? PdfColors.pink
                          : isSickDay ? PdfColors.blue : (isDataAvailable ? PdfColors.white : PdfColors.yellow),
                          child: pw.Text(
                            isDataAvailable ? timesheet.location ?? 'Unknown' : 'Off',
                            style: pw.TextStyle(fontSize: 11),
                          ),
                        ),
                        pw.Container(
                          alignment: pw.Alignment.center,
                          color: isPaidLeave
                          ? PdfColors.pink
                          : isSickDay ? PdfColors.blue : (isDataAvailable ? PdfColors.white : PdfColors.yellow),
                          child: pw.Text(
                            isDataAvailable && timesheet.clockIn != null ? '${timesheet.clockIn!.hour}:${timesheet.clockIn!.minute}' : '-',
                            style: pw.TextStyle(fontSize: 11),
                          ),
                        ),
                        pw.Container(
                          alignment: pw.Alignment.center,
                          color: isPaidLeave
                          ? PdfColors.pink
                          : isSickDay ? PdfColors.blue : (isDataAvailable ? PdfColors.white : PdfColors.yellow),
                          child: pw.Text(
                            isDataAvailable && timesheet.clockOut != null ? '${timesheet.clockOut!.hour}:${timesheet.clockOut!.minute}' : '-',
                            style: pw.TextStyle(fontSize: 11),
                          ),
                        ),
                        pw.Container(
                          alignment: pw.Alignment.center,
                          color: isPaidLeave
                          ? PdfColors.pink
                          : isSickDay ? PdfColors.blue : (isDataAvailable ? PdfColors.white : PdfColors.yellow),
                          child: pw.Text(
                            isDataAvailable ? timesheet.elapsedTime ?? '0' : '-',
                            style: pw.TextStyle(fontSize: 11),
                          ),
                        ),
                        pw.Container(
                          alignment: pw.Alignment.center,
                          color: isPaidLeave
                          ? PdfColors.pink
                          : isSickDay ? PdfColors.blue : (isDataAvailable ? PdfColors.white : PdfColors.yellow),
                          child: pw.Text(
                            isPaidLeave ? "CUTI" : isSickDay ? 'Sick' : isDataAvailable ? "Running ${timesheet.shift}" : 'Off',
                            style: pw.TextStyle(fontSize: 11),
                          ),
                        ),
                      ],
                    ),
                  ];

                  if (overtimeData != null) {
                    rows.add(
                      pw.TableRow(
                        children: [
                          pw.Container(
                            color: PdfColors.green,
                            alignment: pw.Alignment.center,
                            height: 30,
                            child: pw.Text(
                              overtimeData.formattedDate ?? '-',
                              style: pw.TextStyle(fontSize: 11),
                            ),
                          ),
                          pw.Container(
                            color: PdfColors.green,
                            alignment: pw.Alignment.center,
                            height: 30,
                            child: pw.Text(
                              timesheet.grup ?? '-',
                              style: pw.TextStyle(fontSize: 11),
                            ),
                          ),
                          pw.Container(
                            color: PdfColors.green,
                            alignment: pw.Alignment.center,
                            height: 30,
                            child: pw.Text(
                              overtimeData.location ?? '-',
                              style: pw.TextStyle(fontSize: 11),
                            ),
                          ),
                          pw.Container(
                            color: PdfColors.green,
                            alignment: pw.Alignment.center,
                            height: 30,
                            child: pw.Text(
                              overtimeData.formattedStartTime ?? '-',
                              style: pw.TextStyle(fontSize: 11),
                            ),
                          ),
                          pw.Container(
                            color: PdfColors.green,
                            alignment: pw.Alignment.center,
                            height: 30,
                            child: pw.Text(
                              overtimeData.formattedEndTime ?? '-',
                              style: pw.TextStyle(fontSize: 11),
                            ),
                          ),
                          pw.Container(
                            color: PdfColors.green,
                            alignment: pw.Alignment.center,
                            height: 30,
                            child: pw.Text(
                              overtimeData.totalDuration ?? '-',
                              style: pw.TextStyle(fontSize: 11),
                            ),
                          ),
                          pw.Container(
                            color: PdfColors.green,
                            height: 30,
                            alignment: pw.Alignment.center,
                            child: pw.Text(
                              overtimeData.activity ?? '-',
                              style: pw.TextStyle(fontSize: 11),
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return rows;
                }).expand((row) => row).toList(),
              ],
            ),
            pw.SizedBox(height: 20),
            pw.Table(
              border: pw.TableBorder.all(width: 1),
              children: [
                pw.TableRow(
                  children: [
                    pw.Container(
                      height: 120, 
                      child: pw.Column(
                        children: [
                          pw.Text('Engineer EDM',
                            style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold
                            )
                          ),
                          pw.SizedBox(height: 70), 
                          pw.Text('Immanuel Sitompul',
                            style: pw.TextStyle(
                              fontSize: 11
                            )
                          ),
                          pw.Text(formattedDate,
                            style: pw.TextStyle(
                              fontSize: 10
                            )
                          )
                        ],
                      ),
                    ),
                    pw.Container(
                      height: 120, 
                      child: pw.Column(
                        children: [
                          pw.Text('Project Manager',
                            style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold
                            )
                          ),
                          pw.SizedBox(height: 70), 
                          pw.Text('Septian Sakti',
                            style: pw.TextStyle(
                                fontSize: 11
                              )
                          ),
                          pw.Text(formattedDate,
                            style: pw.TextStyle(
                              fontSize: 10
                            )
                          )
                        ],
                      ),
                    ),
                    pw.Container(
                      height: 120, 
                      child: pw.Column(
                        children: [
                          pw.Text('Pembuat Laporan',
                            style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold
                            )
                          ),
                          pw.SizedBox(height: 70), 
                          pw.Text(fullName,
                            style: pw.TextStyle(
                              fontSize: 11
                            )
                          ),
                          pw.Text(formattedDate,
                           style: pw.TextStyle(
                              fontSize: 10
                            ) 
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            )
          ];
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




