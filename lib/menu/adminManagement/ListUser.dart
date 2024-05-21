
import 'package:absent_project/Registration/addUserMenu.dart';
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

  @override
  void initState() {
    super.initState();
    ListUserContoller().getUsers(); // Fetch user list when the widget is initialized
  }

  List<dynamic> users = [];
  var faker = new Faker();

  @override
  Widget build(BuildContext context) {
    const rowSpacer=TableRow(
      children: [
        SizedBox(
          height: 8,
        ),
        SizedBox(
          height: 8,
        )
      ]);

    return Scaffold(
      body : Column(
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
                    ]
                  ),
                  borderRadius: BorderRadius.only(bottomLeft:Radius.circular(34), bottomRight: Radius.circular(34) )
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
                      offset: Offset(0,10,),
                      blurRadius: 50,
                      color: Color.fromARGB(255, 246, 178, 198).withOpacity(0.23),
                    )
                  ]
                ),
                child: TextField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
                    hintText: "Search",
                    hintStyle: TextStyle(color: Colors.grey.withOpacity(0.5)),
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    suffixIcon: Icon(Icons.search_rounded)
                  ),
                ),
              )
            )
            ],
          ),
          FutureBuilder(
              future: ListUserContoller().getUsers(),
              builder: (context, snapshot) {
                if (snapshot.data == null ){
                  return const Text("Loading..");
                }else {
                  return Expanded(
                      child: ListView.builder(
                          itemCount: snapshot.data?.length,
                          itemBuilder: (context, int index) {
                            var user = snapshot.data![index];
                            return Slidable(
                              endActionPane: ActionPane(
                                  motion: BehindMotion(),
                                  children: [
                                    SlidableAction(
                                      backgroundColor: Colors.red,
                                      icon: Icons.delete,
                                      label: "Delete",
                                      onPressed: (context) => _onDissmissed(),
                                    )
                                  ]
                              ),
                              child: ListTile
                                (
                                /*imageUrl: "https://picsum.photos/id/$index/200/300",*/
                                subtitle: Text(user.grup),
                                title:Text(user.username),
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(user.avatarUrl),
                                ),
                                onTap: (){
                                  Get.to(() =>  DetailUser(userList: user));
                                },
                              ),
                            );
                          }
                      )
                  );
                }
              },
          ),

          // FloatingActionButton(onPressed: fetchUser),
          // Expanded(
          //   child : ListView.builder(
          //   itemCount: users.length,
          //   itemBuilder: (context, index){
          //     final user = users[index];
          //     final email = user['email'];
          //     final name = user['name']['first'];
          //     final imageUrl = user['picture']['thumbnail'];
          //     return ListTile
          //      (
          //       leading: CircleAvatar(
          //         backgroundImage: NetworkImage(imageUrl),
          //       ),
          //       title: Text(name),
          //       subtitle: Text(
          //         email,
          //         overflow: TextOverflow.ellipsis
          //         ),
          //       trailing:Icon(Icons.chevron_right),
          //       onTap: (){},
          //     );
          //   }
          // )
          // )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => addUserMenu()));
        },
        backgroundColor: Color.fromARGB(255, 139, 190, 232),
        child: const Icon(Icons.add),
      ),
    );
  }
}


//   void fetchUser() async {
//     print('tes');
//     const url = 'https://randomuser.me/api/?results=20';
//     final uri = Uri.parse(url);
//     final response = await http.get(uri);
//     final body = response.body;
//     final json = jsonDecode(body);
//     setState(() {
//       users = json['results'];
//     });
//     print('fetchUsers Completed');
//   }
// }
void _onDissmissed () {}

/*class UserItem
 extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subtitle;


  UserItem
  ({super.key, 
    required this.imageUrl, 
    required this.subtitle, 
    required this.title 
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      title: Text(title),
      subtitle: Text(
      subtitle,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      ),
      trailing:Icon(Icons.chevron_right),
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const DetailUser()),
        );
      },
    );
  }
}*/

