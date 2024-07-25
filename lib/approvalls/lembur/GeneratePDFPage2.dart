
import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:barcode/barcode.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;

Future<pw.Widget> generatePDFPage2() async {
    final pdf = pw.Document();
    final barcode = Barcode.code128();
    final svg = barcode.toSvg('Septian Sakti');
    // final image = pw.MemoryImage(backgroundImage);

    // final Uint8List backgroundImage = await loadAssetImage('assets/images/BIT-Logo.png');
    // final background = pw.MemoryImage(backgroundImage);

    final Uint8List imageLogo = await loadAssetImage('assets/images/LogoBIT.png');
    final logo = pw.MemoryImage(imageLogo);

    final Uint8List bottomImage = await loadAssetImage('assets/images/bottomDesign.jpg');
    final bottomLogo = pw.MemoryImage(bottomImage);

    final Uint8List logo1 = await loadAssetImage('assets/images/logo1.jpg');
    final image1 = pw.MemoryImage(logo1);

    final Uint8List logo2 = await loadAssetImage('assets/images/logo2.jpg');
    final image2 = pw.MemoryImage(logo2);

    final List<List<String>> data = [
    ['1', 'Rarazu', 'DIIO', '10 Jun 2024', '1', '17:00 s/d 20:00', 'Running Job Shift 2 Menggantikan Ameng'],
    ['2', 'Rarazu', 'DIIO', '11 Jun 2024', '2', '08:00 s/d 17:00', 'Running Job Shift 1 Menggantikan Ameng'],
    ['3', 'Rarazu', 'DIIO', '11 Jun 2024', '2', '08:00 s/d 17:00', 'Running Job Shift 1 Menggantikan Ameng'],
    ];

      
    return pw.Container(
      child: pw.Column(
        children: [
          pw.Row(
            children: [
              pw.Container(
                alignment: pw.Alignment.centerLeft,
                child: pw.Image(logo, width: 200, height: 100)
              ),
              pw.Spacer(),
              pw.Container(
                alignment: pw.Alignment.centerLeft,
                child: pw.Image(image1, width: 80, height: 80)
              ),
              pw.SizedBox(width: 10),
              pw.Container(
                alignment: pw.Alignment.centerLeft,
                child: pw.Image(image2, width: 80, height: 80)
              ),
            ]
          ),
          pw.Center(
            child: pw.Text(
              "SURAT PERINTAH KERJA LEMBUR",
              style: pw.TextStyle(
                fontWeight: pw.FontWeight.bold,
                fontSize: 14
              )
            )
          ),
          pw.SizedBox(height: 20),
          pw.Table(
            border: pw.TableBorder.all(), // Allows to add a border decoration around your table
            children: [ 
              pw.TableRow(children :[
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
                  child: pw.Text('Unit Kerja',  textAlign: pw.TextAlign.center),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.all(4),
                  child: pw.Text('Tanggal',  textAlign: pw.TextAlign.center),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.all(4),
                  child: pw.Text('Shift',  textAlign: pw.TextAlign.center),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.all(4),
                  child: pw.Text('Mulai jam s/d jam',  textAlign: pw.TextAlign.center),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.all(2),
                  child:  pw.Text('Laporan Kegiatan',  
                    textAlign: pw.TextAlign.center
                  ),
                ),
              ]),
              for (var row in data)
              pw.TableRow(children :[
                pw.Container(
                  width: 50,
                  padding: pw.EdgeInsets.all(4),
                  child: pw.Text(row[0], textAlign: pw.TextAlign.center),
                ),
                pw.Container(
                  width: 80,
                  padding: pw.EdgeInsets.all(4),
                  child: pw.Text(row[1], textAlign: pw.TextAlign.center),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.all(4),
                  child: pw.Text(row[2], textAlign: pw.TextAlign.center),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.all(4),
                  child: pw.Text(row[3], textAlign: pw.TextAlign.center),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.all(4),
                  child: pw.Text(row[4], textAlign: pw.TextAlign.center),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.all(4),
                  child: pw.Text(row[5], textAlign: pw.TextAlign.center),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.all(2),
                  child:  pw.Text(row[6], textAlign: pw.TextAlign.center),
                ),
              ]),
            ]
          ),
          pw.Container(
            margin: pw.EdgeInsets.only(top: 20),
            child: pw.Center(
              child: pw.Column(
                children: [
                  pw.Text("Jakarta, 1 September 2023",
                    style: pw.TextStyle(fontSize: 12)
                  ),
                  pw.Text("PT Bringin Inti Teknologi",
                    style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold)
                  )
                ]
              )
            )
          ),
          pw.Padding(
            padding: pw.EdgeInsets.only(top: 10, right: 20),
            child: pw.Row(
              children: [
                pw.Center(
                  child: pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                      pw.Text(
                        'Pengawas Lembur', 
                        style: pw.TextStyle(
                          fontSize: 12
                        )
                      ),
                      pw.SizedBox(height: 20),
                      pw.Container(
                        height: 50,
                        child: pw.SvgImage(svg: svg),
                      ),
                      pw.Text(
                        'Project Manager', 
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
                        'Kepala Divisi', 
                        style: pw.TextStyle(
                          fontSize: 12
                        )
                      ),
                      pw.SizedBox(height: 50),
                      // pw.Container(
                      //   height: 70,
                      //   child: pw.SvgImage(svg: svg),
                      // ),
                      pw.Text(
                        'Adrian Imantaka', 
                        style: pw.TextStyle(
                          fontSize: 12
                        )
                      ),
                      pw.Text(
                        'EVP IT DIIO', 
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
          pw.Spacer(),
          pw.Center(
            child: pw.Image(bottomLogo)
          )
        ]
      )
    );
        

    // return pdf.save();
  }

  Future<Uint8List> loadAssetImage(String path) async {
    final ByteData data = await rootBundle.load(path);
    return data.buffer.asUint8List();
  }


