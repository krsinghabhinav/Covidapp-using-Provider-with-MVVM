import 'dart:io';
import 'package:covidapp/sharepreferance.dart/CreateSharedPreferenceHelper.dart';
import 'package:covidapp/sharepreferance.dart/UserFormfoput.dart';
import 'package:flutter/material.dart';

class UserDetailsScreen extends StatefulWidget {
  @override
  _UserDetailsScreenState createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  String _name = '';
  int _age = 0;
  String _mobileNumber = '';
  String _address = '';
  File? _image;

  // Load saved data from SharedPreferences
  Future<void> _loadUserData() async {
    Map<String, dynamic> userData = await SharedPreferencesHelper.getUserData();
    setState(() {
      _name = userData['name'];
      _age = userData['age'];
      _mobileNumber = userData['mobileNumber'];
      _address = userData['address'];
      if (userData['imagePath'].isNotEmpty) {
        _image = File(userData['imagePath']);
      }
    });
  }

  // Clear data and navigate back to UserFormScreen
  Future<void> _logout() async {
    await SharedPreferencesHelper.clearUserData();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => UserFormScreen()),
    );
  }

  @override
  void initState() {
    super.initState();
    _loadUserData(); // Load data when the screen is initialized
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text('Name: $_name', style: TextStyle(fontSize: 18)),
            Text('Age: $_age', style: TextStyle(fontSize: 18)),
            Text('Mobile Number: $_mobileNumber',
                style: TextStyle(fontSize: 18)),
            Text('Address: $_address', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            _image != null ? Image.file(_image!, height: 100) : Container(),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _logout, // Clear data and go back to the form screen
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
