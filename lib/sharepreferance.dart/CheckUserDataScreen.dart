import 'package:covidapp/sharepreferance.dart/CreateSharedPreferenceHelper.dart';
import 'package:covidapp/sharepreferance.dart/UserFormfoput.dart';
import 'package:covidapp/sharepreferance.dart/showthedata.dart';
import 'package:flutter/material.dart';

class CheckUserDataScreen extends StatefulWidget {
  @override
  _CheckUserDataScreenState createState() => _CheckUserDataScreenState();
}

class _CheckUserDataScreenState extends State<CheckUserDataScreen> {
  @override
  void initState() {
    super.initState();
    _checkUserData();
  }

  // Check if user data exists, and navigate accordingly
  Future<void> _checkUserData() async {
    Map<String, dynamic> userData = await SharedPreferencesHelper.getUserData();
    if (userData['name'].isNotEmpty) {
      // If user data is found, navigate to UserDetailsScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => UserDetailsScreen()),
      );
    } else {
      // If no data is found, show UserFormScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => UserFormScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child:
              CircularProgressIndicator()), // Show a loading indicator while checking data
    );
  }
}
