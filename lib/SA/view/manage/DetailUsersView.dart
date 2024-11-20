import 'dart:ui';
import 'package:flutter/material.dart';
import '../../model/Users.dart';
import '../../services/ApiService.dart';

class DetailUsersView extends StatefulWidget {
  final int? companyId;

  const DetailUsersView({Key? key, required this.companyId}) : super(key: key);

  @override
  _DetailUsersViewState createState() => _DetailUsersViewState();
}

class _DetailUsersViewState extends State<DetailUsersView> {
  final ApiService apiService = ApiService();
  bool _isModalVisible = false;
  Users? _selectedUser;

  void _showUserDetail(Users user) {
    setState(() {
      _isModalVisible = true;
      _selectedUser = user;
    });
  }

  void _hideUserDetail() {
    setState(() {
      _isModalVisible = false;
      _selectedUser = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Users")),
      body: Stack(
        children: [
          FutureBuilder<List<Users>>(
            future: apiService.getUsersByCompanyId(widget.companyId!),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text("Error: ${snapshot.error}"));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text("No users found for this company."));
              } else {
                final users = snapshot.data!;
                return ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index];
                    return ListTile(
                      title: Text(user.full_name!),
                      subtitle: Text(user.email_address!),
                      onTap: () => _showUserDetail(user),
                    );
                  },
                );
              }
            },
          ),

          if (_isModalVisible)
            GestureDetector(
              onTap: _hideUserDetail,
              child: Stack(
                children: [
                  // Area blur
                  Positioned.fill(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                      child: Container(
                        color: Colors.black.withOpacity(0.2),
                      ),
                    ),
                  ),

                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    right: 0,
                    top: 0,
                    bottom: 0,
                    left: MediaQuery.of(context).size.width * 0.25,
                    child: Material(
                      elevation: 8,
                      color: Colors.white,
                      child: Column(
                        children: [
                          AppBar(
                            title: Text(_selectedUser?.full_name ?? "User Detail"),
                            leading: IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: _hideUserDetail,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Name: ${_selectedUser?.full_name ?? 'N/A'}",
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    "Email: ${_selectedUser?.email_address ?? 'N/A'}",
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  const SizedBox(height: 10),
                                  const Text(
                                    "Other Details: Example",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
