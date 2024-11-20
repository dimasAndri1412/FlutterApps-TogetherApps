import 'package:absent_project/SA/view/manage/ListUsersView.dart';
import 'package:flutter/material.dart';

import '../../services/ApiService.dart';
import '../../shared/modal/CreateModal.dart';

class HomeSuperAdmin extends StatelessWidget {
  final ApiService apiService = ApiService();
  HomeSuperAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome"),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListUsersView(),
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (BuildContext context){
                  return const CreateModal();
                }
            );
          },
        child: const Icon(Icons.add),
      ),
    );
  }
}
