import 'package:flutter/material.dart';

import '../../shared/modal/CreateModal.dart';

class HomeSuperAdmin extends StatelessWidget {
  const HomeSuperAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome"),
        backgroundColor: Colors.blueAccent,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            
          ],
        ),
      ),
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
