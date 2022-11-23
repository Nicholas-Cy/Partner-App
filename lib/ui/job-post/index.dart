import 'package:beamcoda_jobs_partners_flutter/data/auth.dart';
import 'package:beamcoda_jobs_partners_flutter/types/job_applicant.dart';
import 'package:beamcoda_jobs_partners_flutter/types/job_post_detailed.dart';
import 'package:beamcoda_jobs_partners_flutter/utils/constants.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../theme_data/fonts.dart';
import '../../components/job-applicant-list-item.dart';
// import '../../components/job-activity-list-item.dart';

class ViewJobPost extends StatefulWidget {
  final int id;
  const ViewJobPost({required Key key, required this.id}) : super(key: key);

  @override
  State<ViewJobPost> createState() => _ViewJobPostState();
}

class _ViewJobPostState extends State<ViewJobPost>
    with TickerProviderStateMixin {
  JobPostDetailed jobPost = JobPostDetailed(
    id: 0,
    title: '',
    deadlineDate: '',
    jobCategory: '',
    isRemote: false,
    jobLocation: '',
    jobType: '',
    desc: '',
    payRangeExists: true,
    skills: [],
  );
  List<JobApplicant> applicants = <JobApplicant>[
    JobApplicant(
      id: 0,
      name: '',
      img: '',
      profession: '',
      shortlisted: false,
      read: false,
    )
  ];

  void initJob(BuildContext ctx) async {
    final userProvider = Provider.of<AuthProvider>(ctx, listen: false);
    String? token = await userProvider.getToken();
    final Uri url = Uri.parse(
        "${AppConstants.API_URL}${AppConstants.JOBS_RETRIEVAL}/${widget.id}");
    final response = await http.get(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        jobPost = JobPostDetailed.fromJson(data["data"]);
        applicants = data["data"]["applicants"]
            .map<JobApplicant>((item) => JobApplicant.fromJson(item))
            .toList();
      });

      print(applicants);

      return;
    } else {
      throw Exception('Problem loading job information.');
    }
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      initJob(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double attributeContainer = 50.0;
    double attributeContainerText = attributeContainer + 10.0;
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
      backgroundColor: const Color.fromRGBO(248, 248, 248, 1.0),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          color: const Color.fromRGBO(248, 248, 248, 1.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(jobPost.title,
                            style: GoogleFonts.dmSans(
                                textStyle: FontThemeData.jobPostName)),
                        const SizedBox(height: 5.0),
                        Text(jobPost.jobLocation,
                            style: GoogleFonts.raleway(
                                textStyle: FontThemeData.jobPostSecondHeading)),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text("Application Deadline",
                            style: GoogleFonts.raleway(
                                textStyle: FontThemeData.jobPostThirdHeading)),
                        const SizedBox(height: 5.0),
                        (jobPost.deadlineDate.isNotEmpty)
                            ? Text(
                                DateFormat("d MMMM yyyy").format(
                                  DateFormat("yyyy-mm-dd hh:mm:ss")
                                      .parse(jobPost.deadlineDate),
                                ),
                                style: GoogleFonts.dmSans(
                                    textStyle:
                                        FontThemeData.jobPostDeadlineDate))
                            : const SizedBox()
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: <Widget>[
                        Text("INDUSTRY",
                            style: GoogleFonts.dmSans(
                                textStyle:
                                    FontThemeData.jobPostAttributesTitle)),
                        const SizedBox(height: 5.0),
                        Image(
                          width: attributeContainer,
                          height: attributeContainer,
                          image: const AssetImage("assets/icons/industry.png"),
                        ),
                        const SizedBox(height: 5.0),
                        SizedBox(
                          width: attributeContainerText,
                          child: Text(
                            jobPost.jobCategory,
                            style: GoogleFonts.dmSans(
                                textStyle: FontThemeData.jobPostAttributesText),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                    (jobPost.isRemote)
                        ? const SizedBox()
                        : Column(
                            children: <Widget>[
                              Text("LOCATION",
                                  style: GoogleFonts.dmSans(
                                      textStyle: FontThemeData
                                          .jobPostAttributesTitle)),
                              const SizedBox(height: 5.0),
                              Image(
                                width: attributeContainer,
                                height: attributeContainer,
                                image: const AssetImage(
                                    "assets/icons/location.png"),
                              ),
                              const SizedBox(height: 10.0),
                              Text(jobPost.jobLocation,
                                  style: GoogleFonts.dmSans(
                                      textStyle:
                                          FontThemeData.jobPostAttributesText)),
                            ],
                          ),
                    Column(
                      children: <Widget>[
                        Text("JOB TYPE",
                            style: GoogleFonts.dmSans(
                                textStyle:
                                    FontThemeData.jobPostAttributesTitle)),
                        const SizedBox(height: 5.0),
                        Image(
                          width: attributeContainer,
                          height: attributeContainer,
                          image: const AssetImage("assets/icons/job-type.png"),
                        ),
                        const SizedBox(height: 10.0),
                        Text(jobPost.jobType,
                            style: GoogleFonts.dmSans(
                                textStyle:
                                    FontThemeData.jobPostAttributesText)),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10.0),
              (jobPost.skills.isNotEmpty)
                  ? Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 5.0),
                      child: Text(
                        "Skills",
                        style: GoogleFonts.raleway(
                            textStyle: FontThemeData.jobPostSecondHeadingBold),
                        textAlign: TextAlign.start,
                      ),
                    )
                  : const SizedBox(),
              (jobPost.skills.isNotEmpty)
                  ? Row(
                      children: <Widget>[
                        SizedBox(
                          width: width - 40.0,
                          height: 40.0,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            clipBehavior: Clip.none,
                            itemCount: jobPost.skills.length,
                            shrinkWrap: true,
                            itemBuilder: (_, i) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: const Color.fromRGBO(
                                        231, 231, 231, 1.0),
                                    backgroundColor: const Color.fromRGBO(
                                        231, 231, 231, 1.0),
                                  ),
                                  child: Text(
                                    jobPost.skills[i],
                                    style: GoogleFonts.dmSans(
                                        textStyle: FontThemeData.btnBlackText),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    )
                  : const SizedBox(),
              const SizedBox(height: 10.0),
              Text(
                jobPost.desc,
                style: GoogleFonts.dmSans(textStyle: FontThemeData.jobPostText),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 10.0),
              (jobPost.payRangeExists)
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10.0),
                        Text("Salary Range",
                            style: GoogleFonts.raleway(
                                textStyle:
                                    FontThemeData.jobPostSalaryRangeTitle)),
                        const SizedBox(height: 2.0),
                        Text("${jobPost.minPayRange} - ${jobPost.maxPayRange}",
                            style: GoogleFonts.dmSans(
                                textStyle:
                                    FontThemeData.jobPostSalaryRangeText))
                      ],
                    )
                  : const SizedBox(),
              const SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  "Applications",
                  style:
                      GoogleFonts.dmSans(textStyle: FontThemeData.btnBlackText),
                ),
              ),
              Column(
                children: [
                  SizedBox(
                    height: 250.0,
                    child: (applicants.isNotEmpty)
                        ? ListView.builder(
                            scrollDirection: Axis.vertical,
                            clipBehavior: Clip.hardEdge,
                            itemCount: applicants.length,
                            shrinkWrap: true,
                            itemBuilder: (_, i) {
                              return JobApplicantListItem(
                                key: UniqueKey(),
                                applicant: applicants[i],
                                callback: () => initJob(context),
                              );
                            },
                          )
                        : Text(
                            "No Applicants",
                            style: GoogleFonts.dmSans(),
                          ),
                  ),
                ],
              ),
              const SizedBox(height: 60.0),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        width: width,
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              width: 2.0,
              color: Colors.black.withOpacity(0.25),
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0, right: 20.0, bottom: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: const Color.fromRGBO(21, 192, 182, 1.0),
                  backgroundColor: const Color.fromRGBO(21, 192, 182, 1.0),
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 25.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      10.0,
                    ),
                  ),
                ),
                onPressed: () {},
                child: Row(
                  children: [
                    const Icon(Icons.edit, size: 15.0, color: Colors.white),
                    const SizedBox(width: 5.0),
                    Text(
                      "EDIT JOB POST",
                      style:
                          GoogleFonts.dmSans(textStyle: FontThemeData.btnText),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 5.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.red,
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 25.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      10.0,
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Row(
                  children: [
                    const Icon(Icons.close, size: 15.0, color: Colors.white),
                    const SizedBox(width: 5.0),
                    Text(
                      "CLOSE POST",
                      style:
                          GoogleFonts.dmSans(textStyle: FontThemeData.btnText),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
