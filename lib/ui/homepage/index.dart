import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme_data/fonts.dart';
import '../../components/shared/job-item.dart';
import '../../components/shared/bottom-navigation.dart';
import '../job-post/new/index.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Container(
          color: const Color.fromRGBO(248, 248, 248, 1.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 10.0),
                Text(
                  "Posted Jobs",
                  style: GoogleFonts.dmSans(
                    textStyle: FontThemeData.sectionTitles,
                  ),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 20.0),
                const JobPost(),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: SizedBox(
        width: width,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10.0, right: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) => NewJobPost(),
                    ),
                  );
                },
                child: Row(
                  children: [
                    const Icon(Icons.add, color: Colors.black, size: 15.0),
                    const SizedBox(width: 5.0),
                    Text(
                      "POST A NEW JOB",
                      style: GoogleFonts.dmSans(
                          textStyle: FontThemeData.btnBlackText),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationElement(
        key: UniqueKey(),
        index: 0,
      ),
    );
  }
}
