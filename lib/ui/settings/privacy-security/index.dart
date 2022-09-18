import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../theme_data/fonts.dart';

class PrivacySecurityPage extends StatelessWidget {
  const PrivacySecurityPage({super.key});

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
              decoration: const BoxDecoration(color: Colors.black),
            ),
            const SizedBox(width: 10.0),
            Text(
              "PARTNER",
              style:
                  GoogleFonts.dmSans(textStyle: FontThemeData.partnerHeading),
            ),
          ],
        ),
        toolbarHeight: 80.0,
        elevation: 0,
        backgroundColor: const Color.fromRGBO(248, 248, 248, 1.0),
        shadowColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          color: const Color.fromRGBO(248, 248, 248, 1.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              const SizedBox(height: 15.0),
              SizedBox(
                width: width - 40.0,
                child: Text(
                  "Privacy & Security",
                  style: GoogleFonts.dmSans(
                      textStyle: FontThemeData.sectionTitles),
                ),
              ),
              const SizedBox(height: 30.0),
              // Terms of Services
              InkWell(
                onTap: () {},
                child: SizedBox(
                  width: width - 140.0,
                  child: Text(
                    "Our Privacy Policy",
                    style: GoogleFonts.dmSans(
                        textStyle: FontThemeData.settingsListItemPrimary),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              // Terms of Services
              InkWell(
                onTap: () {},
                child: SizedBox(
                  width: width - 140.0,
                  child: Text(
                    "Terms of Services",
                    style: GoogleFonts.dmSans(
                        textStyle: FontThemeData.settingsListItemPrimary),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              // Delete Account
              InkWell(
                onTap: () {},
                child: SizedBox(
                  width: width - 140.0,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(Icons.delete, color: Colors.red),
                      const SizedBox(width: 5.0),
                      Text(
                        "Delete Account",
                        style: GoogleFonts.dmSans(
                            textStyle: FontThemeData.settingsListItemPrimary,
                            color: Colors.red),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
