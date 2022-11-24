import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/constants.dart';
import '../types/partner.dart';
import '../types/register_partner.dart';

class AuthProvider extends ChangeNotifier {
  late Partner _partner;
  bool _isAuthenticated = false;

  bool get isAuthenticated => _isAuthenticated;
  Partner get partner => _partner;

  Future<bool> register(RegisterPartner partner) async {
    final Uri uri =
        Uri.parse('${AppConstants.API_URL}${AppConstants.REGISTER_PARTNER}');
    final response = await http.post(uri, body: {
      'img_url': '${AppConstants.API_URL}/img/logo.png',
      'company_name': partner.companyName,
      'short_name': partner.displayName,
      'email': partner.email,
      'password': partner.password,
      'password_confirmation': partner.passwordConfirmation,
      'bio': partner.bio,
      'employee_count': partner.employeeCount
    }, headers: {
      'Accept': 'application/json',
    });

    if (response.statusCode == 201) {
      return true;
    }

    if (response.statusCode == 422) {
      return false;
    }

    return false;
  }

  Future<String> login(String email, String password) async {
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

      final userDetails = await http.get(
          Uri.parse('${AppConstants.API_URL}${AppConstants.PARTNER_DETAILS}'),
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token'
          });

      if (userDetails.statusCode == 200) {
        Map<String, dynamic> userDetailsJson = json.decode(userDetails.body);
        _partner = Partner.fromJson(userDetailsJson["data"]);
      }

      String? fcmToken = await FirebaseMessaging.instance.getToken();

      final Uri uri = Uri.parse(
          '${AppConstants.API_URL}${AppConstants.SAVE_NOTIFICATION_DEVICE}');
      final fcmTokenresponse = await http.post(uri, body: {
        'partner_id': partner.id.toString(),
        'device_key': fcmToken,
      }, headers: {
        'Accept': 'application/json',
      });

      if (fcmTokenresponse.statusCode != 200) {
        return 'Failed to Save Device Information, please try again.';
      }

      notifyListeners();
      return '';
    }

    if (response.statusCode != 200) {
      return json.decode(response.body)['message'];
    }

    return '';
  }

  Future<void> getUserDetails(BuildContext context) async {
    String? token = await getToken();
    final userDetails = await http.get(
        Uri.parse('${AppConstants.API_URL}${AppConstants.PARTNER_DETAILS}'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        });

    if (userDetails.statusCode == 200) {
      Map<String, dynamic> userDetailsJson = json.decode(userDetails.body);
      _partner = Partner.fromJson(userDetailsJson["data"]);
    }
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
