import 'package:flutter/material.dart';

class DetailCutiUser extends StatefulWidget {
  const DetailCutiUser({super.key});

  @override
  State<DetailCutiUser> createState() => _DetailCutiUserState();
}

class _DetailCutiUserState extends State<DetailCutiUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          margin: EdgeInsets.only(left: 50, right: 50, top: 80),
          width: 400,
          height: 600,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(
              color:    Color.fromARGB(255, 147, 195, 234),
              blurRadius: 15,
              offset: Offset(0,10),
            )]
          ),
          child: Column(
            children: [
              Container(
                width: 400,
                height: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20) ),
                  color: Color.fromARGB(255, 104, 187, 254),
                ),
              ),
              DataTable(
                columns: [
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        'Date',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        'Total',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        'Reason',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                  ),
                ], 
                rows: [
                  DataRow(
                    cells: <DataCell>[
                       DataCell(Text('19-02-24 s.d 20-02-24')),
                      DataCell(Text('2')),
                      DataCell(Text('Liburan')),
                    ],
                  ),
                ]
              )
            ],
          ),
        ),
      );
  }
}