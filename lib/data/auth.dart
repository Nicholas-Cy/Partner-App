import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/constants.dart';

class AuthProvider extends ChangeNotifier {
  bool _isAuthenticated = false;

  bool get isAuthenticated => _isAuthenticated;

  Future<bool> login(String email, String password) async {
    final Uri uri =
        Uri.parse('${AppConstants.API_URL}${AppConstants.PARTNER_LOGIN}');
    final response = await http.post(uri, body: {
      'email': email,
      'password': password,
      'device_name': await getDeviceId(),
    }, headers: {
      'Accept': 'application/json',
    });

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      String token = data['data']['token'];
      await saveToken(token);
      _isAuthenticated = true;
      notifyListeners();
      return true;
    }

    if (response.statusCode == 422) {
      return false;
    }

    return false;
  }

  getDeviceId() async {
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo build = await deviceInfoPlugin.androidInfo;
        return build.id;
      } else if (Platform.isIOS) {
        IosDeviceInfo data = await deviceInfoPlugin.iosInfo;
        return data.identifierForVendor;
      }
    } on PlatformException {
      // ignore: avoid_print
      print('Failed to get platform version');
    }
  }

  saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    return token;
  }

  logout() async {
    _isAuthenticated = false;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
