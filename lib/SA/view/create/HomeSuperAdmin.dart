import 'package:absent_project/SA/view/manage/ListCompaniesView.dart';
import 'package:flutter/material.dart';

import '../../shared/modal/CreateCompaniesModal.dart';

class HomeSuperAdmin extends StatelessWidget {
  const HomeSuperAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome"),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListCompaniesView(),
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (BuildContext context){
                  return const CreateCompaniesModal();
                }
            );
          },
        child: const Icon(Icons.add),
      ),
    );
  }
}
