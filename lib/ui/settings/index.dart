import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import './appearance/index.dart';
import './help-support/index.dart';
import './notifications/index.dart';
import './privacy-security/index.dart';
import '../../../logic/cubit/theme_cubit.dart';
import '../../utils/constants.dart';
import '../settings/subscription/index.dart';
import '../theme_data/fonts.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  _launchURL(Uri url) async {
    if (!await launchUrl(url)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final aboutUrl = Uri.parse("${AppConstants.STATIC_WEB_URL}/about-us");
    final otherAppsUrl = Uri.parse("https://beamcoda.com/apps");
    final rateAppUrl = Uri.parse("https://codecanyon.net/downloads");
    final themeCubit = context.read<SwitchCubit>();
    final isDarkThemeOn = themeCubit.state.isDarkThemeOn;

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          color: Theme.of(context).backgroundColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              const SizedBox(height: 15.0),
              Text(
                "Settings",
                style: GoogleFonts.dmSans(
                  textStyle: FontThemeData.sectionTitles,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              const SizedBox(height: 15.0),
              // Subscription
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const SubscriptionPage(),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.attach_money_outlined,
                              size: 30.0,
                              color: Theme.of(context).primaryColor),
                          const SizedBox(width: 10.0),
                          Text(
                            "Subscription",
                            style: GoogleFonts.dmSans(
                              textStyle:
                                  FontThemeData.settingsListItemSecondary,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ],
                      ),
                      Icon(Icons.chevron_right,
                          color: Theme.of(context).primaryColor),
                    ],
                  ),
                ),
              ),
              // Notifications
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const NotificationsPage(),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.alarm_add_outlined,
                              size: 30.0,
                              color: Theme.of(context).primaryColor),
                          const SizedBox(width: 10.0),
                          Text(
                            "Notifications",
                            style: GoogleFonts.dmSans(
                              textStyle:
                                  FontThemeData.settingsListItemSecondary,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ],
                      ),
                      Icon(Icons.chevron_right,
                          color: Theme.of(context).primaryColor),
                    ],
                  ),
                ),
              ),
              // Appearance
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AppearancePage(),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.remove_red_eye,
                              size: 30.0,
                              color: Theme.of(context).primaryColor),
                          const SizedBox(width: 10.0),
                          Text(
                            "Appearance",
                            style: GoogleFonts.dmSans(
                              textStyle:
                                  FontThemeData.settingsListItemSecondary,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ],
                      ),
                      Icon(
                        Icons.chevron_right,
                        color: Theme.of(context).primaryColor,
                      ),
                    ],
                  ),
                ),
              ),
              // Privacy & Security
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const PrivacySecurityPage(),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.lock,
                              size: 30.0,
                              color: Theme.of(context).primaryColor),
                          const SizedBox(width: 10.0),
                          Text(
                            "Privacy & Security",
                            style: GoogleFonts.dmSans(
                                textStyle:
                                    FontThemeData.settingsListItemSecondary,
                                color: Theme.of(context).primaryColor),
                          ),
                        ],
                      ),
                      Icon(Icons.chevron_right,
                          color: Theme.of(context).primaryColor),
                    ],
                  ),
                ),
              ),
              // Help & Support
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const HelpSupportPage(),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.contact_mail,
                              size: 30.0,
                              color: Theme.of(context).primaryColor),
                          const SizedBox(width: 10.0),
                          Text(
                            "Help & Support",
                            style: GoogleFonts.dmSans(
                                textStyle:
                                    FontThemeData.settingsListItemSecondary,
                                color: Theme.of(context).primaryColor),
                          ),
                        ],
                      ),
                      Icon(Icons.chevron_right,
                          color: Theme.of(context).primaryColor),
                    ],
                  ),
                ),
              ),
              // About
              InkWell(
                onTap: () {
                  _launchURL(aboutUrl);
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.question_mark_rounded,
                              size: 30.0,
                              color: Theme.of(context).primaryColor),
                          const SizedBox(width: 10.0),
                          Text(
                            "About",
                            style: GoogleFonts.dmSans(
                                textStyle:
                                    FontThemeData.settingsListItemSecondary,
                                color: Theme.of(context).primaryColor),
                          ),
                        ],
                      ),
                      Icon(Icons.chevron_right,
                          color: Theme.of(context).primaryColor),
                    ],
                  ),
                ),
              ),

              ///  !!! REMOVE THIS BEFORE PRODUCTION RELEASE !!!
              ///  PLEASE CONTACT (hello@beamcoda.com) for further help.
              InkWell(
                onTap: () {
                  _launchURL(otherAppsUrl);
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.card_giftcard,
                              size: 30.0, color: Colors.blue.shade400),
                          const SizedBox(width: 10.0),
                          Text(
                            "Check out our other apps",
                            style: GoogleFonts.dmSans(
                              textStyle:
                                  FontThemeData.settingsListItemSecondary,
                              color: Colors.blue.shade400,
                            ),
                          ),
                        ],
                      ),
                      Icon(Icons.chevron_right, color: Colors.blue.shade400),
                    ],
                  ),
                ),
              ),
              // End of App Showcase Link
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        width: width,
        height: 100.0,
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0, right: 20.0, bottom: 10.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            SizedBox(
              width: 150.0,
              child: InkWell(
                onTap: () {
                  _launchURL(rateAppUrl);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.teal.shade400,
                    ),
                    const SizedBox(width: 5.0),
                    Text(
                      "Rate Our App",
                      style: GoogleFonts.dmSans(
                        textStyle: FontThemeData.btnText,
                        color: Colors.teal.shade400,
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 15.0),
            Text(
              "COPYRIGHT © CARIJOBS 2024 - PRESENT",
              style: GoogleFonts.dmSans(
                textStyle: FontThemeData.btnText,
                color: (isDarkThemeOn)
                    ? Theme.of(context).primaryColor
                    : Colors.grey.shade600,
              ),
            )
          ]),
        ),
      ),
    );
  }
}
