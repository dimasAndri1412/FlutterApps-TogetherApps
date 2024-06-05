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
    final svg = barcode.toSvg('1234567890');
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
                  children: [
                    // pw.Positioned(
                    //   top: 0,
                    //   right: 0,
                    //   child: pw.Image(logo, width: 200, height: 100)
                    // ),
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
                      child: pw.Text("Nama yang dapat dihubungi selama cuti/izin meninggalkan pekerjaan:",
                        style: pw.TextStyle(
                          fontSize: 11,
                        ),
                        textAlign: pw.TextAlign.left,
                      )
                    )
                  ]
                )
              //   pw.Center(
              //   child: pw.Column(
              //     mainAxisAlignment: pw.MainAxisAlignment.center,
              //     children: [
              //       pw.Text('Approved Document', style: pw.TextStyle(fontSize: 24)),
              //       pw.SizedBox(height: 20),
              //       pw.Container(
              //         height: 100,
              //         child: pw.SvgImage(svg: svg),
              //       ),
              //       pw.SizedBox(height: 20),
              //       pw.Text('Barcode: 1234567890'),
              //     ],
              //   ),
              // )
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

