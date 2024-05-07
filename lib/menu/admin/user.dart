import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("Name"),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 147, 195, 234),
                    Color.fromARGB(255, 98, 171, 232),
                    Color.fromARGB(255, 123, 185, 235),
                  ]
                ),
          ),
        ),
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.only(left: 15, top: 20, right: 15),
        child: GestureDetector(
          onTap: (){
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        border: Border.all(width: 4, color: Colors.white),
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: 2,
                            blurRadius: 10,
                            color: Colors.black.withOpacity(0.1)
                          )
                        ],
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image : NetworkImage("https://picsum.photos/id/1/200/300")
                        )
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 4,
                            color: Colors.white
                          ),
                          color: Colors.blue
                        ),
                        child: Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                      )
                    )
                  ],
                ),
              ),
              ListTile(
                title: Text("Name"),
                subtitle: Text(
                "Rara Zahra Urava",
                overflow: TextOverflow.ellipsis
                ),
              ),
              Divider(
                color: Colors.black.withOpacity(0.5),
              ),
              ListTile(
                title: Text("Preferred name"),
                subtitle: Text(
                "Rara",
                overflow: TextOverflow.ellipsis
                ),
              ),
              Divider(
                color: Colors.black.withOpacity(0.5),
              ),
              ListTile(
                title: Text("Role"),
                subtitle: Text(
                "Admin",
                overflow: TextOverflow.ellipsis
                ),
              ),
              Divider(
                color: Colors.black.withOpacity(0.5),
              ),
              ListTile(
                title: Text("Group"),
                subtitle: Text(
                "-",
                overflow: TextOverflow.ellipsis
                ),
              ),
              Divider(
                color: Colors.black.withOpacity(0.5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}