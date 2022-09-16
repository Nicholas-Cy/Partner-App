import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../ui/theme_data/fonts.dart';

class JobPost extends StatelessWidget {
  const JobPost({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width - 40.0,
      padding: const EdgeInsets.symmetric(
        vertical: 15.0,
        horizontal: 20.0,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.0,
          color: const Color.fromRGBO(209, 209, 209, 1.0),
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: -30.0,
            right: -10.0,
            child: Container(
              width: 30.0,
              height: 30.0,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text(
                    "10+",
                    style: GoogleFonts.dmSans(
                        textStyle: FontThemeData.jobItemUnreadNotifications),
                  ),
                ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Senior Web Developer",
                style: GoogleFonts.dmSans(
                  textStyle: FontThemeData.jobItemName,
                ),
              ),
              const SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: const [
                      Icon(Icons.location_on, size: 13.0),
                      Text("S.A, California"),
                    ],
                  ),
                  Text(
                    "1 hour ago",
                    style: GoogleFonts.dmSans(
                      textStyle: FontThemeData.jobItemMomentsAgo,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
