import 'dart:io';
import 'package:covidapp/sharepreferance.dart/CreateSharedPreferenceHelper.dart';
import 'package:covidapp/sharepreferance.dart/showthedata.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserFormScreen extends StatefulWidget {
  @override
  _UserFormScreenState createState() => _UserFormScreenState();
}

class _UserFormScreenState extends State<UserFormScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  File? _image;
  final ImagePicker _picker = ImagePicker();

  // Pick an image from gallery
  Future<void> _pickImage() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  // Save data and navigate to next screen
  Future<void> _saveDataAndNavigate() async {
    String name = _nameController.text;
    int age = int.parse(_ageController.text);
    String mobile = _mobileController.text;
    String address = _addressController.text;
    String imagePath = _image != null ? _image!.path : '';

    // Save data to SharedPreferences
    await SharedPreferencesHelper.saveUserData(
      name: name,
      age: age,
      imagePath: imagePath,
      mobileNumber: mobile,
      address: address,
    );

    // Navigate to the next screen after saving data
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => UserDetailsScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Enter Your Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _ageController,
              decoration: InputDecoration(labelText: 'Age'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _mobileController,
              decoration: InputDecoration(labelText: 'Mobile Number'),
              keyboardType: TextInputType.phone,
            ),
            TextField(
              controller: _addressController,
              decoration: InputDecoration(labelText: 'Address'),
            ),
            SizedBox(height: 10),
            _image != null ? Image.file(_image!, height: 100) : Container(),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Pick Image'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed:
                  _saveDataAndNavigate, // Save and navigate to next screen
              child: Text('Save Data and Go to Next Screen'),
            ),
          ],
        ),
      ),
    );
  }
}
