import 'package:absent_project/approvalls/lembur/DetailLemburUser.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class ListUserLembur extends StatefulWidget {
  const ListUserLembur({super.key});

  @override
  State<ListUserLembur> createState() => _ListUserLemburState();
}

class _ListUserLemburState extends State<ListUserLembur> {
  final faker = Faker();
  late List<Map<String, dynamic>> data;

  @override
  void initState() {
    super.initState();
    data = List.generate(10, (index) {
      return {
        'name': faker.person.name(),
        'date': DateFormat('yyyy-MM-dd').format(faker.date.dateTimeBetween(DateTime(2024, 1, 1), DateTime(2024, 12, 31))),
        'approved': false,
      };
    });
  }

  void approveLeave(int index) {
    setState(() {
      data[index]['approved'] = true;
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Overtime Approval",
            style: TextStyle(fontSize: 15),
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Color.fromARGB(255, 147, 195, 234),
                Color.fromARGB(255, 98, 171, 232),
                Color.fromARGB(255, 123, 185, 235),
              ]),
            ),
          ),
          elevation: 0,
        ),
        body: Container(
            margin: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: DataTable(
                      columns: const <DataColumn>[
                        // DataColumn(
                        //   label: Text('No.'),
                        // ),
                        DataColumn(
                          label: Text('Name'),
                        ),
                        DataColumn(
                          label: Text('Date'),
                        ),
                        DataColumn(
                          label: Text('Action'),
                        ),
                      ],
                      rows: List<DataRow>.generate(
                        data.length,
                        (index) => DataRow(
                          cells: <DataCell>[
                            // DataCell(Text((index + 1).toString())), // Item Count
                            DataCell(Text(
                              data[index]['name']!,
                              maxLines: 2,
                            )),
                            DataCell(Text(data[index]['date']!)),
                            DataCell(IconButton(
                              onPressed: () {
                              DetailLemburUser(context, index, approveLeave);
                            },
                            icon: Icon(
                              data[index]['approved'] ? Icons.check : Icons.timer_sharp,
                            ),
                            color: data[index]['approved']
                                ? Colors.green
                                : Color.fromARGB(255, 238, 198, 42),
                            )),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Total Items: ${data.length}'),
                ),
              ],
            )));
    ;
  }
}
