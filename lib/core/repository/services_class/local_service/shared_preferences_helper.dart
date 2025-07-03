import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static const String _accessTokenKey = 'token';
  static const String _userProfileImage = 'profileImage';
  static const String _userFirstName = 'userFirstName';
  static const String _userLastName = 'userLastName';
  static const String _userPhoneNumber = 'userPhoneNumber';
  static const String _userWorkerId = 'userWorkerId';

  // Save access token
  static Future<void> saveAccessToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_accessTokenKey, token);
    await prefs.setBool('isLogin', true);
  }

  // Retrieve access token
  static Future<String?> getAccessToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_accessTokenKey);
  }

  static Future<String?> getPickerLocationUuid() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('pickerLocationUuid');
  }

  // Clear all data from SharedPreferences
  static Future<void> clearAllData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  static Future<bool?> checkLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("isLogin") ?? false;
  }

  static Future<void> pickerLocationUuid(String uuid) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('pickerLocationUuid', uuid);
  }

  // Save user profile image
  static Future<void> saveUserProfileImage(String profileImage) async {
    if (kDebugMode) {
      print("Profile Image At Shared Pref: $profileImage");
    }
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userProfileImage, profileImage);
  }

  // Retrieve user profile image
  static Future<String?> getUserProfileImage() async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userProfileImage);
  }

  // Save user first name
  static Future<void> saveUserFirstName(String firstName) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userFirstName, firstName);
  }

  // Retrieve user first name
  static Future<String?> getUserFirstName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userFirstName);
  }

  // Save user last name
  static Future<void> saveUserLastName(String lastName) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userLastName, lastName);
  }

  // Retrieve user last name
  static Future<String?> getUserLastName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userLastName);
  }

  // Save user phone number
  static Future<void> saveUserPhoneNumber(String phoneNumber) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userPhoneNumber, phoneNumber);
  }

  // Retrieve user phone number
  static Future<String?> getUserPhoneNumber() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userPhoneNumber);
  }

  // Save user worker ID
  static Future<void> saveUserWorkerId(String workerId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userWorkerId, workerId);
  }


  // Retrieve user worker Id
  static Future<String?> getUserWorkerId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userWorkerId);
  }



}
