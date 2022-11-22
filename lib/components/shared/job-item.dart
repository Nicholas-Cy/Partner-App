import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../ui/theme_data/fonts.dart';
import '../../ui/job-post/index.dart';
import '../../types/jobpostcompact.dart';

class JobPost extends StatelessWidget {
  final JobPostCompact jobPost;
  const JobPost({required Key key, required this.jobPost}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => const ViewJobPost(),
          ),
        );
      },
      child: Container(
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
                      (jobPost.applicantsCount > 99)
                          ? "99+"
                          : jobPost.applicantsCount.toString(),
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
                  jobPost.title,
                  style: GoogleFonts.dmSans(
                    textStyle: FontThemeData.jobItemName,
                  ),
                ),
                const SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.location_on, size: 13.0),
                        Text(jobPost.location),
                      ],
                    ),
                    Text(
                      DateFormat('d M yyyy').format(
                        DateFormat('dd-mm-yyyy hh:mm:ss')
                            .parse(jobPost.timeAgo),
                      ),
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
      ),
    );
  }
}
