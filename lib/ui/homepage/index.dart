import 'package:beamcoda_jobs_partners_flutter/data/job.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../theme_data/fonts.dart';
import '../../components/shared/job-item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final jobProvider = Provider.of<JobProvider>(context, listen: false);
      jobProvider.loadJobs(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final jobProvider = Provider.of<JobProvider>(context);
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
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: jobProvider.jobs.length,
                itemBuilder: (_, i) {
                  return JobPost(
                    key: UniqueKey(),
                    jobPost: jobProvider.jobs[i],
                  );
                },
              ),
              const SizedBox(height: 60.0),
            ],
          ),
        ),
      ),
    );
  }
}
