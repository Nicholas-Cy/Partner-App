import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../components/main/switch.dart';
import '../../../data/auth.dart';
import '../../../types/notification_settings.dart';
import '../../../utils/constants.dart';
import '../../theme_data/fonts.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  late NotificationSettings settings;

  Future<NotificationSettings> loadNotificationsSettings(
      BuildContext ctx) async {
    final userProvider = Provider.of<AuthProvider>(ctx, listen: false);
    String? token = await userProvider.getToken();
    final partnerId = userProvider.partner.id;
    final Uri url = Uri.parse(
        "${AppConstants.API_URL}${AppConstants.PARTNER_NOTIFICATION_SETTINGS}/$partnerId");
    final response = await http.get(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      settings = NotificationSettings.fromJson(data['data']);

      return settings;
    } else {
      throw Exception('Problem loading notification settings.');
    }
  }

  Future<void> saveNotificationSettings(
      BuildContext ctx, String objectKey) async {
    late NotificationSettings saveSettings;
    final userProvider = Provider.of<AuthProvider>(ctx, listen: false);
    String? token = await userProvider.getToken();
    final partnerId = userProvider.partner.id;
    final Uri url = Uri.parse(
        "${AppConstants.API_URL}${AppConstants.PARTNER_NOTIFICATION_SAVE_SETTINGS}");
    if (objectKey == 'jobexpiry') {
      saveSettings = NotificationSettings(
          jobExpiry: (settings.jobExpiry) ? false : true,
          newApplicants: settings.newApplicants);
    } else if (objectKey == 'newapplicants') {
      saveSettings = NotificationSettings(
          jobExpiry: settings.jobExpiry,
          newApplicants: (settings.newApplicants) ? false : true);
    }
    final response = await http.post(
      url,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(
        {
          'partner_id': partnerId.toString(),
          'job_expiry': (saveSettings.jobExpiry == true) ? "1" : "0",
          'new_applicants': (saveSettings.newApplicants == true) ? "1" : "0",
        },
      ),
    );
    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception('Problem saving notification settings.');
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Image(
              width: 85.0,
              image: AssetImage('assets/images/logo.png'),
            ),
            const SizedBox(width: 10.0),
            Container(
              width: 1.0,
              height: 20.0,
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            ),
            const SizedBox(width: 10.0),
            Text(
              "PARTNER",
              style: GoogleFonts.dmSans(
                textStyle: FontThemeData.partnerHeading,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
        toolbarHeight: 80.0,
        elevation: 0,
        backgroundColor: Theme.of(context).backgroundColor,
        shadowColor: Colors.transparent,
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: FutureBuilder<NotificationSettings>(
          future: loadNotificationsSettings(context),
          builder: (context, future) {
            if (!future.hasData) {
              return Container();
            } else {
              final NotificationSettings? settings = future.data;
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                color: Theme.of(context).backgroundColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    const SizedBox(height: 15.0),
                    SizedBox(
                      width: width - 40.0,
                      child: Text(
                        "Send Notifications",
                        style: GoogleFonts.dmSans(
                          textStyle: FontThemeData.sectionTitles,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30.0),
                    // Job Selected Alert
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: width - 100.0,
                          child: Text(
                            "New Applicants for Job Posts",
                            style: GoogleFonts.dmSans(
                              textStyle:
                                  FontThemeData.settingsListItemSecondary,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                          child: CustomToggleSwitch(
                            value: settings!.newApplicants,
                            key: UniqueKey(),
                            onChange: () {
                              saveNotificationSettings(
                                  context, 'newapplicants');
                              loadNotificationsSettings(context);
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    // Usage Inactivity Alert
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: width - 100.0,
                          child: Text(
                            "Job expires in a week",
                            style: GoogleFonts.dmSans(
                              textStyle:
                                  FontThemeData.settingsListItemSecondary,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                          child: CustomToggleSwitch(
                            value: settings.jobExpiry,
                            key: UniqueKey(),
                            onChange: () {
                              saveNotificationSettings(context, 'jobexpiry');
                              loadNotificationsSettings(context);
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
