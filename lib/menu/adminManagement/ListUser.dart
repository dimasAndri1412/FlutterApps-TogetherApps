import 'package:absent_project/Registration/addUserMenu.dart';
import 'package:absent_project/RevampRegistrations/RevampRegistrationPages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:faker/faker.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:absent_project/menu/adminManagement/DetailUser.dart';

import '../../controller/ListAndDetailUserController/ListUserController.dart';

class ListUser extends StatefulWidget {
  const ListUser({super.key});

  @override
  State<ListUser> createState() => _ListUserState();
}

class _ListUserState extends State<ListUser> {
  ListUserController _controller = ListUserController();
  List<dynamic> users = [];
  var faker = new Faker();

  @override
  void initState() {
    super.initState();
    _fetchUsers(); // Fetch user list when the widget is initialized
  }

  Future<void> _fetchUsers() async {
    var fetchedUsers = await _controller.getUsers();
    setState(() {
      users = fetchedUsers ?? [];
    });
  }

  Future<void> _onDismissed(String email) async {
    var response = await _controller.deleteUser(email);
    if (response['success']) {
      await _fetchUsers();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response['message'])),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to delete user")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    const rowSpacer = TableRow(
      children: [
        SizedBox(height: 8),
        SizedBox(height: 8),
      ],
    );

    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 120,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 147, 195, 234),
                      Color.fromARGB(255, 98, 171, 232),
                      Color.fromARGB(255, 123, 185, 235),
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(34),
                    bottomRight: Radius.circular(34),
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                left: 0,
                right: 0,
                child: Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(26),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 10),
                        blurRadius: 50,
                        color: Color.fromARGB(255, 246, 178, 198).withOpacity(0.23),
                      ),
                    ],
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
                      hintText: "Search",
                      hintStyle: TextStyle(color: Colors.grey.withOpacity(0.5)),
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      prefixIcon: IconButton(
                        onPressed: (){
                          Get.back();
                        },
                        icon: Icon(
                          Icons.arrow_back_ios_new,
                        ),
                      ),
                      suffixIcon: Icon(Icons.search_rounded),
                    ),
                  ),
                ),
              ),
            ],
          ),
          FutureBuilder(
            future: _controller.getUsers(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text("Error loading users"));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text("No users found"));
              } else {
                return Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, int index) {
                      var user = snapshot.data![index];
                      return Slidable(
                        key: ValueKey(user.email),
                        endActionPane: ActionPane(
                          motion: const BehindMotion(),
                          children: [
                            SlidableAction(
                              backgroundColor: Colors.red,
                              icon: Icons.delete,
                              label: "Delete",
                              onPressed: (context) => _onDismissed(user.email),
                            ),
                          ],
                        ),
                        child: ListTile(
                          subtitle: Text(user.grup),
                          title: Text(user.fullname),
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(user.avatarUrl),
                          ),
                          onTap: () {
                            Get.to(() => DetailUser(userList: user));
                          },
                        ),
                      );
                    },
                  ),
                );
              }
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => revampRegistrationPages()),
          );
        },
        backgroundColor: Color.fromARGB(255, 98, 171, 232),
        child: const Icon(
            Icons.add,
            color: Colors.white,
        ),
      ),
    );
  }
}
