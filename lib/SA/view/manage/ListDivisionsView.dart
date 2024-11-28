import 'package:absent_project/SA/shared/modal/CreateDivisionsModal.dart';
import 'package:absent_project/SA/view/manage/ListProjectsView.dart';
import 'package:flutter/material.dart';
import '../../controller/DivisionController.dart';
import '../../model/Divisions.dart';

class ListDivisionsView extends StatelessWidget {
  final int? companyId;

  const ListDivisionsView({super.key, required this.companyId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Divisions"),
      ),
      body: FutureBuilder<List<Divisions>>(
        future: DivisionController.getDivisionsByCompanyId(companyId!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No divisions found for this company."));
          } else {
            final divisions = snapshot.data!;
            return ListView.builder(
              itemCount: divisions.length,
              itemBuilder: (context, index) {
                final division = divisions[index];
                return ListTile(
                  title: Text(division.division_name),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ListProjectsView(companyId: companyId, divisionId: division.id),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (BuildContext context) => CreateDivisionsModal(companyId: companyId,)
            );
          },
        child: const Icon(Icons.add),
      ),
    );
  }
}
