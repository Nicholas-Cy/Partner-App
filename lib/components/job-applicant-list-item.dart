import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../ui/theme_data/fonts.dart';

class JobApplicantListItem extends StatelessWidget {
  const JobApplicantListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: InkWell(
        onTap: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Image(
                  image: AssetImage('assets/images/logo.png'),
                  width: 50.0,
                  height: 50.0,
                ),
                const SizedBox(width: 10.0),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "John Smith",
                      style: GoogleFonts.dmSans(
                          textStyle: FontThemeData.profileName),
                    ),
                    const SizedBox(height: 2.0),
                    Text(
                      "Mid-Level UI/UX Designer",
                      style: GoogleFonts.dmSans(
                          textStyle: FontThemeData.profileOccupation),
                    ),
                  ],
                ),
              ],
            ),
            IconButton(
              padding: const EdgeInsets.all(0.0),
              onPressed: () {},
              icon: const Icon(
                Icons.file_download_done,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
