import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme_data/fonts.dart';
import '../../components/shared/job-item.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
    );
  }
}
