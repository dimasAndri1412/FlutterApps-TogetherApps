import 'package:flutter/material.dart';
import '../../controller/UserController.dart';
import '../../model/Companies.dart';
import '../../shared/custom/AutoRefreshList.dart';
import '../../shared/custom/BlurredListTile.dart';
import 'ListDivisionsView.dart';

class ListCompaniesView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Companies")),
      body: AutoRefreshList<Companies>(
        fetchData: UserController.getCompany,
        builder: (context, companies) {
          return ListView.builder(
            itemCount: companies.length,
            itemBuilder: (context, index) {
              final company = companies[index];
              return BlurredListTile(
                isLoading: false,
                data: company.company_name,
                trailing: const Icon(Icons.arrow_forward),
                child: ListTile(
                  title: Text(company.company_name),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ListDivisionsView(companyId: company.id),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
    // return Scaffold(
    //   appBar: AppBar(title: const Text("Companies")),
    //   body: FutureBuilder<List<Companies>>(
    //     future: UserController.getCompany(),
    //     builder: (context, snapshot) {
    //       if (snapshot.connectionState == ConnectionState.waiting) {
    //         return ListView.builder(
    //           itemCount: 5, // Placeholder jumlah item
    //           itemBuilder: (context, index) {
    //             return const BlurredListTile(
    //               isLoading: true,
    //               data: null
    //             );
    //           },
    //         );
    //       } else if (snapshot.hasError) {
    //         return Center(child: Text("Error: ${snapshot.error}"));
    //       } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
    //         return const Center(child: Text("No companies found."));
    //       } else {
    //         final companies = snapshot.data!;
    //         return ListView.builder(
    //           itemCount: companies.length,
    //           itemBuilder: (context, index) {
    //             final company = companies[index];
    //             return ListTile(
    //               title: Text(company.company_name),
    //               onTap: () {
    //                 Navigator.push(
    //                   context,
    //                   MaterialPageRoute(
    //                     builder: (context) =>
    //                         ListDivisionsView(companyId: company.id),
    //                   ),
    //                 );
    //               },
    //             );
    //           },
    //         );
    //       }
    //     },
    //   ),
    // );
  }
}
