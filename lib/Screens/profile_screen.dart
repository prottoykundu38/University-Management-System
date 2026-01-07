import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:univarsity_management_system/Screens/login_page.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _image;
  final picker = ImagePicker();

  // Profile Data
  String name = 'Your Name';
  String email = 'youremail@gmail.com';
  int participated = 6;
  int going = 4;
  int interested = 1;
  String gender = 'Male';
  String dob = '01 Jan 2000';
  String university = 'DIU';
  String className = 'CSE-31A';
  String topics = 'AI, ML, Flutter';

  final _formKey = GlobalKey<FormState>();

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _editProfile() {
    String tempName = name;
    String tempEmail = email;
    String tempGender = gender;
    String tempDob = dob;
    String tempUniversity = university;
    String tempClassName = className;
    String tempTopics = topics;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Profile', style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.white,
          content: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildTextField('Name', tempName, (v) => tempName = v),
                  _buildTextField('Email', tempEmail, (v) => tempEmail = v),
                  _buildTextField('Gender', tempGender, (v) => tempGender = v),
                  _buildTextField('DOB', tempDob, (v) => tempDob = v),
                  _buildTextField(
                    'University',
                    tempUniversity,
                    (v) => tempUniversity = v,
                  ),
                  _buildTextField(
                    'Class',
                    tempClassName,
                    (v) => tempClassName = v,
                  ),
                  _buildTextField('Topics', tempTopics, (v) => tempTopics = v),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    name = tempName;
                    email = tempEmail;
                    gender = tempGender;
                    dob = tempDob;
                    university = tempUniversity;
                    className = tempClassName;
                    topics = tempTopics;
                  });
                  Navigator.pop(context);
                }
              },
              child: Text(
                'Save',
                style: TextStyle(
                  color: Color(0xFF4A2A11),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTextField(
    String label,
    String initial,
    Function(String) onChanged,
  ) {
    return TextFormField(
      initialValue: initial,
      decoration: InputDecoration(labelText: label),
      onChanged: onChanged,
      validator: (value) => value!.isEmpty ? 'Enter $label' : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Profile',
          style: TextStyle(
            color: const Color.fromARGB(255, 63, 43, 1),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('assets/images/main_logo.png', height: 32),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: PopupMenuButton<String>(
              icon: Icon(
                Icons.more_vert,
                color: Color.fromARGB(255, 63, 43, 1), // Dark Brown color
              ),
              onSelected: (value) {
                if (value == 'edit') {
                  // Edit Profile logic here
                } else if (value == 'logout') {
                  // Perform logout logic (e.g., clearing session data, etc.)

                  // Navigate to LoginPage and remove the current screen from the stack
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                }
              },
              itemBuilder:
                  (context) => [
                    PopupMenuItem(
                      value: 'logout',
                      child: Container(
                        color: Colors.red, // Red background
                        padding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 15,
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.exit_to_app,
                              color: Colors.white,
                            ), // Logout icon
                            SizedBox(width: 10),
                            Text(
                              'Logout',
                              style: TextStyle(
                                color: Colors.white, // White text
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                             Icon(
                              Icons.exit_to_app,
                              color: Colors.white,
                            ), // Logout icon
                            SizedBox(width: 10),
                            Text(
                              'Logout',
                              style: TextStyle(
                                color: Colors.white, // White text
                                fontWeight: FontWeight.bold,
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
        flexibleSpace: ClipRRect(
          borderRadius: BorderRadius.circular(30), // Rounds all four corners
          child: Container(color: const Color(0xFFD1A170)),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundImage:
                      _image != null
                          ? FileImage(_image!)
                          : AssetImage('assets/images/d_profile.png') as ImageProvider,
                ),
                Positioned(
                  bottom: 0,
                  right: 4,
                  child: GestureDetector(
                    onTap: _pickImage,
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: Color(0xFFD1A170),
                      child: Icon(
                        Icons.camera_alt,
                        size: 18,
                        color: Color(0xFF4A2A11),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(name, style: theme.textTheme.headlineSmall),
            Text(email, style: theme.textTheme.bodyMedium),
            const SizedBox(height: 16),

            // Stats Card
            Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 8,
                ),
                child: IntrinsicHeight(
                  // Ensures dividers span full height
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: _buildStatColumn(participated, 'Participated'),
                      ),
                      VerticalDivider(thickness: 1.5, color: Color(0xFF4A2A11)),
                      Expanded(child: _buildStatColumn(going, 'Going')),
                      VerticalDivider(thickness: 1.5, color: Color(0xFF4A2A11)),
                      Expanded(
                        child: _buildStatColumn(interested, 'Interested'),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Details with icons
            _buildInfoTile(Icons.person, 'Gender', gender),
            _buildInfoTile(Icons.cake, 'DOB', dob),
            _buildInfoTile(Icons.school, 'University', university),
            _buildInfoTile(Icons.class_, 'Class', className),
            _buildInfoTile(Icons.topic, 'Interested Topics', topics),

            const SizedBox(height: 24),

            // Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _editProfile,
                    icon: Icon(Icons.edit),
                    label: Text('Edit'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFD1A170),
                      foregroundColor: Color(0xFF4A2A11),
                      padding: EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                // Expanded(
                //   child: ElevatedButton.icon(
                //     onPressed: () {
                //       // Logout logic here
                //     },
                //     icon: Icon(Icons.logout),
                //     label: Text('Logout'),
                //     style: ElevatedButton.styleFrom(
                //       backgroundColor: Colors.red,
                //       foregroundColor: Colors.white,
                //       padding: EdgeInsets.symmetric(vertical: 14),
                //     ),
                //   ),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatColumn(int number, String label) {
    return Column(
      children: [
        Text(
          '$number',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        Text(label),
      ],
    );
  }

  Widget _buildInfoTile(IconData icon, String title, String value) {
    return ListTile(
      leading: Icon(icon, color: Color(0xFF4A2A11)),
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(value),
      dense: true,
      contentPadding: EdgeInsets.symmetric(horizontal: 8),
    );
  }
}
