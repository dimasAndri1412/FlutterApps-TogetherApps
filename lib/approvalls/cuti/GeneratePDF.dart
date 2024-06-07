// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:pdf/pdf.dart';
import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
// import 'package:path_provider/path_provider.dart';
// import 'package:printing/printing.dart';
import 'package:barcode/barcode.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;

// Future<Uint8List> loadImage(String path) async {
//   final data = await rootBundle.load(path);
//   return data.buffer.asUint8List();
// }

Future<Uint8List> GeneratePDF() async {
    final pdf = pw.Document();
    final barcode = Barcode.code128();
    final svg = barcode.toSvg('Septian Sakti');
    // final image = pw.MemoryImage(backgroundImage);

    final Uint8List backgroundImage = await loadAssetImage('assets/images/BIT-Logo.png');
    final background = pw.MemoryImage(backgroundImage);

    final Uint8List imageLogo = await loadAssetImage('assets/images/LogoBIT.png');
    final logo = pw.MemoryImage(imageLogo);

    pdf.addPage(
      pw.Page(
        build: (context) {
          return pw.Container(
            child: pw.Stack(
              children: [
                pw.Opacity(
                  opacity: 0.2,
                  child: pw.Center(
                    child: pw.Container(
                      margin: pw.EdgeInsets.only(top: 80),
                      width: 500,
                      height: 500,
                      decoration: pw.BoxDecoration(
                        image: pw.DecorationImage(
                          image: background,
                          fit: pw.BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                pw.Column(
                  mainAxisAlignment: pw.MainAxisAlignment.start,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Row(
                      children: [
                        pw.Container(
                          child : pw.Text(
                            "BIT-Req-1023",
                            style: pw.TextStyle(
                              fontSize: 10,
                            )
                          )
                        ),
                        pw.Spacer(),
                        pw.Opacity(
                          opacity: 0.5,
                          child: pw.Image(logo, width: 200, height: 100)
                        )
                      ]
                    ),
                    pw.Container(
                      margin: pw.EdgeInsets.all(10),
                      child: pw.Column(
                        children: [
                          pw.Center(
                            child: pw.Text(
                              "PERMOHONAN IZIN/CUTI MENINGGALKAN PEKERJAAN",
                              style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                                fontSize: 14
                              )
                            )
                          )
                        ]
                      )
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
                                "Rara Zahra Urava",
                                style: pw.TextStyle(
                                  fontSize: 11
                                )
                              )
                            ]
                          ),
                          pw.Row(
                            children: [
                              pw.Text(
                                "Jabatan : ",
                                style: pw.TextStyle(
                                  fontSize: 11
                                )
                              ),
                              pw.Text(
                                "IT Data Operator",
                                style: pw.TextStyle(
                                  fontSize: 11
                                )
                              )
                            ]
                          ),
                          pw.Row(
                            children: [
                              pw.Text(
                                "Departemen : ",
                                style: pw.TextStyle(
                                  fontSize: 11
                                )
                              ),
                              pw.Text(
                                "DIIO",
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
                      margin: pw.EdgeInsets.only(top: 5, left: 20, bottom: 5),
                      child: pw.Row(
                        children: [
                          pw.Text(
                            "Mengajukan permohonan untuk: : ",
                            style: pw.TextStyle(
                              fontSize: 11
                            )
                          ),
                          pw.Text(
                            "Pulang Kampung dulu brow",
                            style: pw.TextStyle(
                              fontSize: 11,
                              decoration: pw.TextDecoration.underline
                            )
                          )
                        ]
                      ),
                    ),
                    pw.Container(
                      margin: pw.EdgeInsets.all(20),
                      alignment: pw.Alignment.centerLeft,
                      child: pw.RichText(
                        text: pw.TextSpan(
                          children: [
                            pw.TextSpan(
                              text: 'Nama yang dapat dihubungi selama cuti/izin meninggalkan pekerjaan:\n',
                              style: pw.TextStyle(
                                fontSize: 11, 
                              ),
                            ),
                            pw.TextSpan(
                              text: 'Rara Zahra Urava',
                              style: pw.TextStyle(
                                fontSize: 11, 
                                decoration: pw.TextDecoration.underline,
                                fontStyle: pw.FontStyle.italic
                              ),
                            ),
                            pw.TextSpan(
                              text: ' No. Telp/HP : ',
                              style: pw.TextStyle(fontSize: 11),
                            ),
                            pw.TextSpan(
                              text: '08561132005\n',
                              style: pw.TextStyle(
                                fontSize: 11, 
                                decoration: pw.TextDecoration.underline,
                                fontStyle: pw.FontStyle.italic
                              ),
                            ),
                            pw.TextSpan(
                              text: 'Dari Tanggal ',
                              style: pw.TextStyle(fontSize: 11),
                            ),
                            pw.TextSpan(
                              text: '19 Juni 2024',
                              style: pw.TextStyle(
                                fontSize: 11, 
                                fontWeight: pw.FontWeight.bold,
                                decoration: pw.TextDecoration.underline,
                              ),
                            ),
                            pw.TextSpan(
                              text: 'Sampai tanggal ',
                              style: pw.TextStyle(fontSize: 11),
                            ),
                            pw.TextSpan(
                              text: '__20 Juni 2024___ ',
                              style: pw.TextStyle(
                                fontSize: 11, 
                                fontWeight: pw.FontWeight.bold,
                                decoration: pw.TextDecoration.underline,
                              ),
                            ),
                            pw.TextSpan(
                              text: '( ',
                              style: pw.TextStyle(fontSize: 11),
                            ),
                            pw.TextSpan(
                              text: '2',
                              style: pw.TextStyle(
                                fontSize: 11, 
                                fontWeight: pw.FontWeight.bold,
                                decoration: pw.TextDecoration.underline,
                              ),
                            ),
                            pw.TextSpan(
                              text: ' Hari Kerja)\n',
                              style: pw.TextStyle(fontSize: 11),
                            ),
                            pw.TextSpan(
                              text: 'Dan kembali bekerja pada tanggal ',
                              style: pw.TextStyle(fontSize: 11),
                            ),
                            pw.TextSpan(
                              text: '21 Juni 2024',
                              style: pw.TextStyle(
                                fontSize: 11, 
                                fontWeight: pw.FontWeight.bold,
                                decoration: pw.TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    pw.Container(
                      width: 250,
                      height: 170,
                      margin: pw.EdgeInsets.only(left: 20, top: 10),
                      alignment: pw.Alignment.centerLeft,
                      decoration: pw.BoxDecoration(
                        border: pw.Border.all()
                      ),
                      child: pw.Padding(
                        padding: pw.EdgeInsets.only(top: 10, left: 5, right: 10),
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text(
                              "Untuk dicek oleh petugas HC : ",
                              style: pw.TextStyle(
                                fontSize: 11,
                                fontWeight: pw.FontWeight.bold
                              )
                            ),
                            pw.Divider(
                              thickness: 0.5
                            ),
                            pw.Row(
                              children: [
                                pw.Text(
                                  "A ",
                                  style: pw.TextStyle(
                                    fontSize: 11,
                                  )
                                ),
                                pw.Text(
                                  "Hak Cuti Saat ini",
                                  style: pw.TextStyle(
                                    fontSize: 11,
                                  )
                                ),
                                pw.Spacer(),
                                pw.Text(
                                  " : 12 Hari ",
                                  style: pw.TextStyle(
                                    fontSize: 11,
                                  )
                                ),
                              ]
                            ),
                            pw.Row(
                              children: [
                               pw.Padding(
                                padding: pw.EdgeInsets.only(left: 10),
                                child:  pw.Text(
                                  "Sisa Cuti Periode lalu ",
                                  style: pw.TextStyle(
                                    fontSize: 11,
                                  )
                                ),
                               ),
                                pw.Spacer(),
                                pw.Text(
                                  " : 10 Hari ",
                                  style: pw.TextStyle(
                                    fontSize: 11,
                                  )
                                ),
                              ]
                            ),
                            pw.Row(
                              children: [
                                pw.Padding(
                                padding: pw.EdgeInsets.only(left: 10),
                                child:  pw.Text(
                                  "Hak Cuti ",
                                  style: pw.TextStyle(
                                    fontSize: 11,
                                    fontWeight: pw.FontWeight.bold
                                  )
                                ),
                               ),
                                pw.Spacer(),
                                pw.Text(
                                  " : 10 Hari ",
                                  style: pw.TextStyle(
                                    fontSize: 11,
                                    fontWeight: pw.FontWeight.bold
                                  )
                                ),
                              ]
                            ),
                            pw.SizedBox(height: 10),
                            pw.Row(
                              children: [
                                pw.Text(
                                  "B ",
                                  style: pw.TextStyle(
                                    fontSize: 11,
                                  )
                                ),
                                pw.Text(
                                  "Telah laksanakan Cuti",
                                  style: pw.TextStyle(
                                    fontSize: 11,
                                  )
                                ),
                                pw.Spacer(),
                                pw.Text(
                                  " : 2 Hari ",
                                  style: pw.TextStyle(
                                    fontSize: 11,
                                  )
                                ),
                              ]
                            ),
                            pw.Row(
                              children: [
                               pw.Padding(
                                padding: pw.EdgeInsets.only(left: 10),
                                child:  pw.Text(
                                  "Permohonan Cuti ",
                                  style: pw.TextStyle(
                                    fontSize: 11,
                                  )
                                ),
                               ),
                                pw.Spacer(),
                                pw.Text(
                                  " : 2 Hari ",
                                  style: pw.TextStyle(
                                    fontSize: 11,
                                  )
                                ),
                              ]
                            ),
                            pw.Row(
                              children: [
                                pw.Padding(
                                padding: pw.EdgeInsets.only(left: 10),
                                child:  pw.Text(
                                  "Total ",
                                  style: pw.TextStyle(
                                    fontSize: 11,
                                    fontWeight: pw.FontWeight.bold
                                  )
                                ),
                               ),
                                pw.Spacer(),
                                pw.Text(
                                  " : 4 Hari ",
                                  style: pw.TextStyle(
                                    fontSize: 11,
                                    fontWeight: pw.FontWeight.bold
                                  )
                                ),
                              ]
                            ),
                            pw.SizedBox(height: 10),
                            pw.Row(
                              children: [
                                pw.Text(
                                  "C ",
                                  style: pw.TextStyle(
                                    fontSize: 11,
                                  )
                                ),
                                pw.Text(
                                  "Sisa Cuti (A-B)",
                                  style: pw.TextStyle(
                                    fontSize: 11,
                                  )
                                ),
                                pw.Spacer(),
                                pw.Text(
                                  " : 8 Hari ",
                                  style: pw.TextStyle(
                                    fontSize: 11,
                                  )
                                ),
                              ]
                            ),
                          ]
                        )
                      )
                    ),
                    pw.Padding(
                      padding: pw.EdgeInsets.only(top: 30, right: 20),
                      child: pw.Row(
                        children: [
                          pw.Container(),
                          pw.Spacer(),
                            pw.Center(
                            child: pw.Column(
                              mainAxisAlignment: pw.MainAxisAlignment.center,
                              children: [
                                pw.Text(
                                  'Jakarta, 07-06-2024', 
                                  style: pw.TextStyle(
                                    fontSize: 14
                                  )
                                ),
                                pw.SizedBox(height: 20),
                                pw.Container(
                                  height: 70,
                                  child: pw.SvgImage(svg: svg),
                                ),
                              ],
                            ),
                          )
                        ]
                      )
                    ),
                    pw.Spacer(),
                    pw.Center(
                      child: pw.Column(
                        children: [
                          pw.Text("PT BRINGIN INTI TEKNOLOGI",
                            style: pw.TextStyle(
                              fontSize: 14,
                              fontWeight: pw.FontWeight.bold
                            )
                          ),
                          pw.Text(
                            "Intiland Tower lantain 12A | Jalan Jend. Sudirman No. 32 | Jakarta Pusat 10220 ",
                            style: pw.TextStyle(
                              fontSize: 9,
                            )
                          ),
                          pw.Text(
                            "Tel. (62-21) 5790 6373 - 5790 6303 | Website. www.briit.co.id ",
                            style: pw.TextStyle(
                              fontSize: 9,
                            )
                          )
                        ]
                      )
                    )
                  ]
                )
              ],
            )
          );
        },
      ),
    );

    return pdf.save();
  }

  Future<Uint8List> loadAssetImage(String path) async {
    final ByteData data = await rootBundle.load(path);
    return data.buffer.asUint8List();
  }


// class GeneratePDF extends  StatelessWidget {
//   const GeneratePDF({super.key});
  
//   Future<void> generatePdf() async {
//   final pdf = pw.Document();
//   // final font = await PdfGoogleFonts.nunitoExtraLight();
//   final fontData = await rootBundle.load('assets/fonts/Roboto/Roboto-Regular.ttf');
//   final ttf = pw.Font.ttf(fontData);

//   pdf.addPage(
//     pw.Page(
//       build: (pw.Context context) {
//         return pw.Center(
//           child: pw.Text('Hello World',
//             style: pw.TextStyle(
//               font: ttf,
//             )
//           ),
//         );
//       },
//     ),
//   );

//   final output = await getTemporaryDirectory();
//   final file = File("${output.path}/example.pdf");
//   await file.writeAsBytes(await pdf.save());
// }
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }

