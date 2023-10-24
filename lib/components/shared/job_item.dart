import 'package:beamcoda_jobs_partners_flutter/logic/cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../types/jobpostcompact.dart';
import '../../ui/job-post/index.dart';
import '../../ui/theme_data/fonts.dart';

class JobPost extends StatelessWidget {
  final JobPostCompact jobPost;
  const JobPost({required Key key, required this.jobPost}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final themeCubit = context.read<SwitchCubit>();
    final isDarkThemeOn = themeCubit.state.isDarkThemeOn;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ViewJobPost(key: UniqueKey(), id: jobPost.id),
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
          color: (isDarkThemeOn) ? Theme.of(context).primaryColor : null,
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            (jobPost.applicantsCount > 0)
                ? Positioned(
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
                                textStyle:
                                    FontThemeData.jobItemUnreadNotifications),
                          ),
                        ),
                      ),
                    ),
                  )
                : const SizedBox(),
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
                      DateFormat('d MMMM yyyy').format(
                        DateFormat('yyyy-mm-dd hh:mm:ss')
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
