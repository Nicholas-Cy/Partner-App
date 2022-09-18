import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../theme_data/fonts.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

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
                  "CodaJobs Pvt. Ltd",
                  style: GoogleFonts.dmSans(
                      textStyle: FontThemeData.sectionTitles),
                ),
              ),
              const SizedBox(height: 20.0),
              SizedBox(
                width: width - 40.0,
                child: Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Faucibus lobortis lectus elementum feugiat ac. Egestas ac viverra magna vitae nulla suspendisse scelerisque condimentum. Pulvinar vel habitant nibh volutpat, ultrices ullamcorper auctor. Elit sagittis, imperdiet pretium id blandit consectetur nec. Erat orci, eu, amet in vivamus a curabitur. Et nulla donec nibh ac erat. Rhoncus sapien, fames pulvinar massa fames sem consectetur lacus.",
                  style:
                      GoogleFonts.dmSans(textStyle: FontThemeData.settingsText),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
