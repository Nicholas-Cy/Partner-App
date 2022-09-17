import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../ui/theme_data/fonts.dart';

class JobActivityListItem extends StatelessWidget {
  const JobActivityListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 5.0),
            child: Icon(Icons.circle, color: Colors.green),
          ),
          const SizedBox(width: 10.0),
          RichText(
            softWrap: true,
            overflow: TextOverflow.fade,
            text: TextSpan(
              text: 'ABC, Inc',
              style: GoogleFonts.dmSans(
                textStyle: FontThemeData.btnBlackText,
                color: Colors.blue,
              ),
              children: const <TextSpan>[
                TextSpan(
                  text: ' posted the job ',
                  style: TextStyle(
                    color: Colors.black45,
                  ),
                ),
                TextSpan(
                  text: 'UI UX Designer',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.0),
            child: Icon(
              Icons.circle,
              color: Colors.black38,
              size: 8.0,
            ),
          ),
          Text(
            "2 weeks ago",
            style: GoogleFonts.dmSans(
                textStyle: FontThemeData.btnBlackText, color: Colors.black45),
          )
        ],
      ),
    );
  }
}
