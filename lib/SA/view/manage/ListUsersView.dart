// import 'package:absent_project/SA/view/manage/Buttons.dart';
import 'package:absent_project/SA/view/manage/DetailUsersView.dart';
import 'package:flutter/material.dart';
import '../../model/Companies.dart';
import '../../services/ApiService.dart';

class ListUsersView extends StatelessWidget {
  final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Companies")),
      body: FutureBuilder<List<Companies>>(
        future: apiService.getCompany(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No companies found."));
          } else {
            final companies = snapshot.data!;
            return ListView.builder(
              itemCount: companies.length,
              itemBuilder: (context, index) {
                final company = companies[index];
                return ListTile(
                  title: Text(company.company_name),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DetailUsersView(companyId: company.id),
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
