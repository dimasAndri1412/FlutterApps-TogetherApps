import 'package:absent_project/approvalls/lembur/GeneratePDFPage2.dart';
import 'package:absent_project/controller/ApprovalController/MemberRequestOvertime/MemberRequestOvertimeGetListModel.dart';
import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:barcode/barcode.dart';
import 'package:printing/printing.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;

// import '../../controller/ApprovalController/AdminApprovalOvertime/AdminApprovalOvertimeModel.dart';

class GeneratePDFOvertimeUser extends StatelessWidget {
  MemberRequestOvertimeGetListModel getData;
  // AdminApprovalOvertimeModel getData;
  GeneratePDFOvertimeUser({super.key, required this.getData});

  Future<Uint8List> GeneratePDF() async {
    final pdf = pw.Document();
    final barcode = Barcode.code128();
    final svg = barcode.toSvg('Septian Sakti');

    final Uint8List imageLogo =
        await loadAssetImage('assets/images/LogoBIT.png');
    final logo = pw.MemoryImage(imageLogo);

    final Uint8List bottomImage =
        await loadAssetImage('assets/images/bottomDesign.jpg');
    final bottomLogo = pw.MemoryImage(bottomImage);

    final Uint8List logo1 = await loadAssetImage('assets/images/logo1.jpg');
    final image1 = pw.MemoryImage(logo1);

    final Uint8List logo2 = await loadAssetImage('assets/images/logo2.jpg');
    final image2 = pw.MemoryImage(logo2);

    pdf.addPage(
      pw.Page(
        build: (context) {
          return pw.Container(
              child: pw.Column(children: [
            pw.Row(children: [
              pw.Container(
                  alignment: pw.Alignment.centerLeft,
                  child: pw.Image(logo, width: 200, height: 100)),
              pw.Spacer(),
              pw.Container(
                  alignment: pw.Alignment.centerLeft,
                  child: pw.Image(image1, width: 80, height: 80)),
              pw.SizedBox(width: 10),
              pw.Container(
                  alignment: pw.Alignment.centerLeft,
                  child: pw.Image(image2, width: 80, height: 80)),
            ]),
            pw.Center(
                child: pw.Text("SURAT PERINTAH KERJA LEMBUR",
                    style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold, fontSize: 14))),
            pw.Container(
                alignment: pw.Alignment.centerLeft,
                margin: pw.EdgeInsets.all(10),
                child: pw.Text(
                    "Diperintahkan kepada Pekerja tersebut di bawah ini :")),
            pw.Table(
                border: pw.TableBorder
                    .all(), // Allows to add a border decoration around your table
                children: [
                  pw.TableRow(children: [
                    pw.Container(
                      width: 50,
                      padding: pw.EdgeInsets.all(4),
                      child: pw.Text("No", textAlign: pw.TextAlign.center),
                    ),
                    pw.Container(
                      width: 80,
                      padding: pw.EdgeInsets.all(4),
                      child: pw.Text("Nama", textAlign: pw.TextAlign.center),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(4),
                      child:
                          pw.Text('Unit Kerja', textAlign: pw.TextAlign.center),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(4),
                      child: pw.Text('Tanggal / Bulan',
                          textAlign: pw.TextAlign.center),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(4),
                      child: pw.Text('Mulai jam s/d jam',
                          textAlign: pw.TextAlign.center),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(2),
                      child: pw.Text('Keterangan (lokasi pekerjaan)',
                          textAlign: pw.TextAlign.center),
                    ),
                  ]),
                  pw.TableRow(children: [
                    pw.Container(
                      width: 50,
                      padding: pw.EdgeInsets.all(4),
                      child: pw.Text("1", textAlign: pw.TextAlign.center),
                    ),
                    pw.Container(
                      width: 80,
                      padding: pw.EdgeInsets.all(4),
                      child: pw.Text(getData.full_name,
                          textAlign: pw.TextAlign.center),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(4),
                      child: pw.Text(getData.department,
                          textAlign: pw.TextAlign.center),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(4),
                      child: pw.Text(getData.start_date,
                          textAlign: pw.TextAlign.center),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(4),
                      child: pw.Text(
                          '${getData.start_time} s/d ${getData.end_time}',
                          textAlign: pw.TextAlign.center),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(2),
                      child: pw.Text(getData.location,
                          textAlign: pw.TextAlign.center),
                    ),
                  ]),
                ]),
            pw.Container(
              margin: pw.EdgeInsets.only(top: 20, left: 3),
              alignment: pw.Alignment.centerLeft,
              child: pw.RichText(
                text: pw.TextSpan(
                  children: [
                    pw.TextSpan(
                      text:
                          'Untuk melaksanakan kerja lembur pada waktu sebagaimana tercantum pada kolom di atas, dengan tugas sbb :\n',
                      style: pw.TextStyle(
                        fontSize: 11,
                      ),
                    ),
                    pw.WidgetSpan(
                      child: pw.SizedBox(width: 20), // Tambahkan jarak spesifik
                    ),
                    pw.TextSpan(
                      text: getData.activity,
                      style: pw.TextStyle(
                        fontSize: 11,
                        decoration: pw.TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            pw.Container(
                margin: pw.EdgeInsets.only(top: 20, left: 3),
                alignment: pw.Alignment.centerLeft,
                child: pw.Column(children: [
                  pw.Text(
                      "Pengawasan pelaksanaan kerja lembur diserahkan kepada :"),
                  pw.Container(
                      alignment: pw.Alignment.centerLeft,
                      width: 300,
                      child: pw.Row(children: [
                        pw.Text("Nama"),
                        pw.SizedBox(width: 50),
                        pw.Text(": Septian Sakti")
                      ])),
                  pw.Container(
                      alignment: pw.Alignment.centerLeft,
                      width: 300,
                      child: pw.Row(children: [
                        pw.Text("Jabatan"),
                        pw.SizedBox(width: 40),
                        pw.Text(": Project Manager")
                      ]))
                ])),
            pw.Container(
                margin: pw.EdgeInsets.only(top: 20, left: 3),
                alignment: pw.Alignment.centerLeft,
                child: pw.Text(
                    "Demikian Surat Perintah Kerja Lembur ini dibuat dan untuk dilaksanakan dengan sebaik-baiknya dengan penuh rasa tanggung jawab.")),
            pw.Padding(
                padding: pw.EdgeInsets.only(top: 30, right: 20),
                child: pw.Row(children: [
                  pw.Container(),
                  pw.Spacer(),
                  pw.Center(
                    child: pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      children: [
                        pw.Text('Jakarta, ', style: pw.TextStyle(fontSize: 12)),
                        pw.Text('PT Bringin Inti Teknologi',
                            style: pw.TextStyle(fontSize: 12)),
                        pw.SizedBox(height: 60),
                        pw.Container(
                            // height: 70,
                            // child: pw.SvgImage(svg: svg),
                            ),
                        pw.Text('EVP IT DIIO',
                            style: pw.TextStyle(fontSize: 12)),
                      ],
                    ),
                  )
                ])),
            pw.Spacer(),
            pw.Center(child: pw.Image(bottomLogo))
          ]));
        },
      ),
    );

// PAGE 2
    final page2 = await generatePDFPage2();
    pdf.addPage(
      pw.Page(
        build: (context) => page2,
      ),
    );

    // await Printing.layoutPdf(
    //   onLayout: (PdfPageFormat format) async => pdf.save()
    // );

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
