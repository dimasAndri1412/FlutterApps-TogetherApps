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
  @override
  Widget build(BuildContext context) {
    final faker = Faker();
    final List<Map<String, String>> data = List.generate(10, (index) {
      return {
        'name': faker.person.name(),
        'date': DateFormat('yyyy-MM-dd').format(faker.date
            .dateTimeBetween(DateTime(2024, 1, 1), DateTime(2024, 12, 31))),
      };
    });

    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Overtime Approval",
            style: TextStyle(fontSize: 15),
          ),
<<<<<<< HEAD
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
                    DataCell(Text(data[index]['name']! , maxLines: 2,)),
                    DataCell(Text(data[index]['date']!)),
                    DataCell(IconButton(onPressed: (){
                      DetailLemburUser(context);
                    }, 
                    icon: Icon(Icons.timer_sharp), 
                    color: Color.fromARGB(255, 238, 198, 42),
                    )),
                  ],
                ),
              ),
=======
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Color.fromARGB(255, 147, 195, 234),
                Color.fromARGB(255, 98, 171, 232),
                Color.fromARGB(255, 123, 185, 235),
              ]),
>>>>>>> 9897c6368ebb24e07579004b61a2ac0713f3443d
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
                              onPressed: () {},
                              icon: Icon(Icons.list_alt),
                              color: Colors.blue,
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
