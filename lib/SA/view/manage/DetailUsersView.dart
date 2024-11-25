import 'dart:ui';
import 'package:flutter/material.dart';
import '../../model/Users.dart';
import '../../services/ApiService.dart';

class DetailUsersView extends StatefulWidget {
  final int? companyId;
  final int? divisionId;
  final int? projectId;
  final ApiService apiService = ApiService();

  DetailUsersView({
    Key? key,
    required this.companyId,
    required this.divisionId,
    required this.projectId,
  }) : super(key: key);

  @override
  _DetailUsersViewState createState() => _DetailUsersViewState();
}

class _DetailUsersViewState extends State<DetailUsersView> {
  bool _isModalVisible = false;
  Users? _selectedUser;

  // Controllers untuk TextFormField
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _companyController = TextEditingController();
  final _divisionController = TextEditingController();
  final _projectController = TextEditingController();
  final List<TextEditingController> _newProjectControllers = []; // List untuk project baru

  void _showUserDetail(Users user) {
    setState(() {
      _isModalVisible = true;
      _selectedUser = user;

      // Mengisi nilai awal dari TextFormField
      _nameController.text = user.full_name ?? '';
      _emailController.text = user.email_address ?? '';
      _phoneController.text = user.phone_number ?? '';
      _addressController.text = user.address ?? '';
      _companyController.text = user.company_name ?? '';
      _divisionController.text = user.division_name ?? '';
      _projectController.text = user.project_name ?? '';
      _newProjectControllers.clear(); // Reset project baru
    });
  }

  void _hideUserDetail() {
    setState(() {
      _isModalVisible = false;
      _selectedUser = null;
      _newProjectControllers.clear(); // Reset semua project baru
    });
  }

  void _addNewProjectField() {
    setState(() {
      _newProjectControllers.add(TextEditingController());
    });
  }

  void _removeNewProjectField(int index) {
    setState(() {
      _newProjectControllers.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Users")),
      body: Stack(
        children: [
          FutureBuilder<List<Users>>(
            future: widget.apiService.getUsersByCompanyIdAndDivisionId(
              widget.companyId!,
              widget.divisionId!,
              widget.projectId!,
            ),
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
                                  TextFormField(
                                    controller: _nameController,
                                    decoration: const InputDecoration(labelText: "Name"),
                                    readOnly: true,
                                  ),
                                  const SizedBox(height: 10),
                                  TextFormField(
                                    controller: _emailController,
                                    decoration: const InputDecoration(labelText: "Email"),
                                    readOnly: true,
                                  ),
                                  const SizedBox(height: 10),
                                  TextFormField(
                                    controller: _phoneController,
                                    decoration: const InputDecoration(labelText: "Phone Number"),
                                    readOnly: true,
                                  ),
                                  const SizedBox(height: 10),
                                  TextFormField(
                                    controller: _addressController,
                                    decoration: const InputDecoration(labelText: "Address"),
                                    readOnly: true,
                                  ),
                                  const SizedBox(height: 10),
                                  TextFormField(
                                    controller: _companyController,
                                    decoration: const InputDecoration(labelText: "Company"),
                                    readOnly: true,
                                  ),
                                  const SizedBox(height: 10),
                                  TextFormField(
                                    controller: _divisionController,
                                    decoration: const InputDecoration(labelText: "Division"),
                                    readOnly: true,
                                  ),
                                  const SizedBox(height: 10),
                                  TextFormField(
                                    controller: _projectController,
                                    decoration: const InputDecoration(labelText: "Existing Project"),
                                    readOnly: true,
                                  ),
                                  const SizedBox(height: 20),
                                  for (int i = 0; i < _newProjectControllers.length; i++)
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 10),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: TextFormField(
                                              controller: _newProjectControllers[i],
                                              decoration: const InputDecoration(
                                                labelText: "New Project",
                                              ),
                                            ),
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.cancel),
                                            onPressed: () => _removeNewProjectField(i),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ElevatedButton(
                                    onPressed: _addNewProjectField,
                                    child: const Text("Add New Project Field"),
                                  ),
                                  const SizedBox(height: 20),
                                  ElevatedButton(
                                    onPressed: () async {
                                      try {
                                        for (var controller in _newProjectControllers) {
                                          if (controller.text.isNotEmpty) {
                                            await widget.apiService.addNewProjectAndAssignUser(
                                              _selectedUser!.id!,
                                              controller.text,
                                            );
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(content: Text("Project '${controller.text}' added successfully!")),
                                            );
                                          }
                                        }
                                        _hideUserDetail();
                                      } catch (e) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text("Error: $e")),
                                        );
                                      }
                                    },
                                    child: const Text("Save Projects"),
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
