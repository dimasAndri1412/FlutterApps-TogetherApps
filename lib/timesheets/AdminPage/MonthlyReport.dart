import 'package:absent_project/controller/TimeSheetsController/TimesheetAdmin/ListTimesheetsController.dart';
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

    ListTimesheetsController listTimesheetsController = ListTimesheetsController();
    MonthlyTimesheetModel timesheets = await listTimesheetsController.getMonthlyReport(userId, selectedMonth, selectedYear);
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
                )
              ]
            ),
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

