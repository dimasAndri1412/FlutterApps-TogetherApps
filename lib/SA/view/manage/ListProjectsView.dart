import 'package:absent_project/SA/controller/UserController.dart';
import 'package:absent_project/SA/view/manage/DetailUsersView.dart';
import 'package:flutter/material.dart';
import '../../model/Divisions.dart';
import '../../model/Projects.dart';

class ListProjectsView extends StatefulWidget {
  final int? companyId;
  final int? divisionId;

  const ListProjectsView({super.key, required this.companyId, required this.divisionId});

  @override
  _LListProjectsViewState createState() => _LListProjectsViewState();
}

class _LListProjectsViewState extends State<ListProjectsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Projects"),
      ),
      body: FutureBuilder<List<Projects>>(
        future: UserController.getProjectByCompanyIdAndDivisionId(widget.companyId!, widget.divisionId!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No divisions found for this company."));
          } else {
            final projects = snapshot.data!;
            return ListView.builder(
              itemCount: projects.length,
              itemBuilder: (context, index) {
                final project = projects[index];
                return ListTile(
                  title: Text(project.project_name),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailUsersView(companyId: widget.companyId, divisionId: widget.divisionId, projectId: project.id,),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
