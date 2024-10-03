import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static const String _keyName = 'name';
  static const String _keyAge = 'age';
  static const String _keyMobile = 'mobile';
  static const String _keyAddress = 'address';
  static const String _keyImagePath = 'imagePath';

  static Future<void> saveUserData({
    required String name,
    required int age,
    required String imagePath,
    required String mobileNumber,
    required String address,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyName, name);
    await prefs.setInt(_keyAge, age);
    await prefs.setString(_keyMobile, mobileNumber);
    await prefs.setString(_keyAddress, address);
    await prefs.setString(_keyImagePath, imagePath);
  }

  static Future<Map<String, dynamic>> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String name = prefs.getString(_keyName) ?? '';
    int age = prefs.getInt(_keyAge) ?? 0;
    String mobileNumber = prefs.getString(_keyMobile) ?? '';
    String address = prefs.getString(_keyAddress) ?? '';
    String imagePath = prefs.getString(_keyImagePath) ?? '';
    return {
      'name': name,
      'age': age,
      'mobileNumber': mobileNumber,
      'address': address,
      'imagePath': imagePath,
    };
  }

  static Future<void> clearUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
