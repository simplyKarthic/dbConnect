import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveUserName(String name) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('user_name', name);
}

Future<String> getUserName() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('user_name');
}

// Store map data in shared preferences
Future<void> saveMapData(Map<String, dynamic> mapData) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String json = jsonEncode(mapData);
  await prefs.setString('map_data', json);
}

// Retrieve map data from shared preferences
Future<Map<String, dynamic>> getMapData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String json = prefs.getString('map_data');
  if (json != null) {
    return jsonDecode(json);
  } else {
    return null;
  }
}

Future<void> clearData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.clear();
}

Future<void> removeData(String spName) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove(spName);
}