import 'package:absent_project/SA/controller/UserController.dart';
import 'package:absent_project/SA/shared/modal/CreateDivisionsModal.dart';
import 'package:absent_project/SA/view/manage/DetailUsersView.dart';
import 'package:absent_project/SA/view/manage/ListProjectsView.dart';
import 'package:flutter/material.dart';
import '../../model/Divisions.dart';

class ListDivisionsView extends StatefulWidget {
  final int? companyId;

  const ListDivisionsView({super.key, required this.companyId});

  @override
  _ListDivisionsViewState createState() => _ListDivisionsViewState();
}

class _ListDivisionsViewState extends State<ListDivisionsView> {

  @override
  void initState() {
    super.initState();
    print("Received companyId: ${widget.companyId}");
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Divisions"),
      ),
      body: FutureBuilder<List<Divisions>>(
        future: UserController.getDivisionsByCompanyId(widget.companyId!),
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
                        builder: (context) => ListProjectsView(companyId: widget.companyId, divisionId: division.id),
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
                builder: (BuildContext context) => CreateDivisionsModal(companyId: widget.companyId,)
            );
          },
        child: const Icon(Icons.add),
      ),
    );
  }
}
