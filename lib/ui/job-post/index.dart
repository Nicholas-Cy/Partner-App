import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme_data/fonts.dart';
import '../../components/job-applicant-list-item.dart';
import '../../components/job-activity-list-item.dart';

class ViewJobPost extends StatefulWidget {
  const ViewJobPost({super.key});

  @override
  State<ViewJobPost> createState() => _ViewJobPostState();
}

class _ViewJobPostState extends State<ViewJobPost>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(
      length: 2,
      vsync: this,
      animationDuration: const Duration(milliseconds: 200),
    );
    super.initState();
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
                        Text("UI/UX Designer",
                            style: GoogleFonts.dmSans(
                                textStyle: FontThemeData.jobPostName)),
                        const SizedBox(height: 5.0),
                        Text("S.A, California",
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
                        Text("1st May, 2023",
                            style: GoogleFonts.dmSans(
                                textStyle: FontThemeData.jobPostDeadlineDate))
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
                            "Information Technology",
                            style: GoogleFonts.dmSans(
                                textStyle: FontThemeData.jobPostAttributesText),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Text("LOCATION",
                            style: GoogleFonts.dmSans(
                                textStyle:
                                    FontThemeData.jobPostAttributesTitle)),
                        const SizedBox(height: 5.0),
                        Image(
                          width: attributeContainer,
                          height: attributeContainer,
                          image: const AssetImage("assets/icons/location.png"),
                        ),
                        const SizedBox(height: 10.0),
                        Text("S.A, California",
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
                        Text("Internship",
                            style: GoogleFonts.dmSans(
                                textStyle:
                                    FontThemeData.jobPostAttributesText)),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 5.0),
                child: Text(
                  "Skills",
                  style: GoogleFonts.raleway(
                      textStyle: FontThemeData.jobPostSecondHeadingBold),
                  textAlign: TextAlign.start,
                ),
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        primary: const Color.fromRGBO(231, 231, 231, 1.0),
                      ),
                      child: Text(
                        "JavaScript",
                        style: GoogleFonts.dmSans(
                            textStyle: FontThemeData.btnBlackText),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      primary: const Color.fromRGBO(231, 231, 231, 1.0),
                    ),
                    child: Text(
                      "CSS",
                      style: GoogleFonts.dmSans(
                          textStyle: FontThemeData.btnBlackText),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pretium vitae mauris dui ac et suscipit. Porttitor duis semper urna, leo. Diam sagittis id blandit et proin enim amet. Ridiculus neque id sagittis fames eros enim leo bibendum elementum. Massa tortor mauris tempus duis sit at tellus tristique aliquet. Tortor non ultrices est diam. Eget dui duis arcu eros leo. Mauris nibh ultricies commodo laoreet in etiam. Pellentesque magna et est, ultricies duis pellentesque velit quam velit.",
                style: GoogleFonts.dmSans(textStyle: FontThemeData.jobPostText),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 10.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10.0),
                  Text("Salary Range",
                      style: GoogleFonts.raleway(
                          textStyle: FontThemeData.jobPostSalaryRangeTitle)),
                  const SizedBox(height: 2.0),
                  Text("\$4000 - \$7000 / Mo",
                      style: GoogleFonts.dmSans(
                          textStyle: FontThemeData.jobPostSalaryRangeText))
                ],
              ),
              const SizedBox(height: 20.0),
              TabBar(
                controller: _tabController,
                tabs: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      "Applications",
                      style: GoogleFonts.dmSans(
                          textStyle: FontThemeData.btnBlackText),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      "Activity",
                      style: GoogleFonts.dmSans(
                          textStyle: FontThemeData.btnBlackText),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 250.0,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    SingleChildScrollView(
                      clipBehavior: Clip.none,
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: const [
                          JobApplicantListItem(),
                          JobApplicantListItem(),
                          JobApplicantListItem(),
                          JobApplicantListItem(),
                          JobApplicantListItem(),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      clipBehavior: Clip.none,
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          SizedBox(height: 20.0),
                          JobActivityListItem(),
                          JobActivityListItem(),
                        ],
                      ),
                    ),
                  ],
                ),
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
                  primary: const Color.fromRGBO(21, 192, 182, 1.0),
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
                    const Icon(Icons.edit, size: 15.0),
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
                  primary: Colors.red,
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
                    const Icon(Icons.close, size: 15.0),
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
