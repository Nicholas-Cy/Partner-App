import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../theme_data/fonts.dart';
import '../../theme_data/inputs.dart';

class NewJobPost extends StatelessWidget {
  NewJobPost({super.key});

  final industryTypes = ['Information Technology', 'Healthcare', 'Shipping'];
  final jobTypes = ['Full-Time', 'Part-Time', 'Internship'];
  final jobDurations = ['2 Weeks', '4 Weeks', '2 Months'];

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
      backgroundColor: const Color.fromRGBO(248, 248, 248, 1.0),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          color: const Color.fromRGBO(248, 248, 248, 1.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5.0),
              Text(
                "Post a new job",
                style: GoogleFonts.dmSans(
                  textStyle: FontThemeData.sectionTitleSecondary,
                ),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 10.0),
              // Job Title
              Padding(
                padding: const EdgeInsets.only(
                  top: 10.0,
                  bottom: 10.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Job Title",
                      style: GoogleFonts.dmSans(
                          textStyle: FontThemeData.inputLabel),
                    ),
                    const SizedBox(height: 2.0),
                    TextFormField(
                      style: const TextStyle(
                        color: Colors.black,
                        decorationColor: Colors.black,
                      ),
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 5.0),
                        filled: true,
                        fillColor: Colors.white,
                        hintStyle:
                            const TextStyle(color: Colors.grey, fontSize: 15.0),
                        enabledBorder: InputsThemeData.inputForm,
                        focusedBorder: InputsThemeData.inputFormSelected,
                      ),
                    ),
                  ],
                ),
              ),
              // Remote Work Checkbox
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Checkbox(
                    value: false,
                    onChanged: (value) {},
                  ),
                  Text(
                    "This position is remote",
                    style: GoogleFonts.dmSans(
                        textStyle: FontThemeData.btnBlackText),
                  ),
                ],
              ),
              //Town & City
              Row(
                children: [
                  // Town
                  SizedBox(
                    width: (width / 2) - 30.0,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 10.0,
                        bottom: 10.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Town",
                            style: GoogleFonts.dmSans(
                                textStyle: FontThemeData.inputLabel),
                          ),
                          const SizedBox(height: 2.0),
                          TextFormField(
                            style: const TextStyle(
                              color: Colors.black,
                              decorationColor: Colors.black,
                            ),
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 5.0, horizontal: 5.0),
                              filled: true,
                              fillColor: Colors.white,
                              hintStyle: const TextStyle(
                                  color: Colors.grey, fontSize: 15.0),
                              enabledBorder: InputsThemeData.inputForm,
                              focusedBorder: InputsThemeData.inputFormSelected,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 20.0),
                  // City
                  SizedBox(
                    width: (width / 2) - 30.0,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 10.0,
                        bottom: 10.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "City",
                            style: GoogleFonts.dmSans(
                                textStyle: FontThemeData.inputLabel),
                          ),
                          const SizedBox(height: 2.0),
                          TextFormField(
                            style: const TextStyle(
                              color: Colors.black,
                              decorationColor: Colors.black,
                            ),
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 5.0, horizontal: 5.0),
                              filled: true,
                              fillColor: Colors.white,
                              hintStyle: const TextStyle(
                                  color: Colors.grey, fontSize: 15.0),
                              enabledBorder: InputsThemeData.inputForm,
                              focusedBorder: InputsThemeData.inputFormSelected,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              // Country
              SizedBox(
                width: width - 40.0,
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 10.0,
                    bottom: 10.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Country",
                        style: GoogleFonts.dmSans(
                            textStyle: FontThemeData.inputLabel),
                      ),
                      const SizedBox(height: 2.0),
                      TextFormField(
                        style: const TextStyle(
                          color: Colors.black,
                          decorationColor: Colors.black,
                        ),
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 5.0),
                          filled: true,
                          fillColor: Colors.white,
                          hintStyle: const TextStyle(
                              color: Colors.grey, fontSize: 15.0),
                          enabledBorder: InputsThemeData.inputForm,
                          focusedBorder: InputsThemeData.inputFormSelected,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Industry Type
              SizedBox(
                width: width - 40.0,
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 10.0,
                    bottom: 10.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Industry",
                        style: GoogleFonts.dmSans(
                            textStyle: FontThemeData.inputLabel),
                      ),
                      const SizedBox(height: 2.0),
                      Container(
                        width: width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: const Color.fromRGBO(51, 65, 85, 1.0)
                                .withOpacity(0.2),
                            width: 2.0,
                          ),
                        ),
                        child: DropdownButton(
                          isExpanded: true,
                          items: industryTypes.map((String type) {
                            return DropdownMenuItem(
                              value: type,
                              child: Text(type),
                            );
                          }).toList(),
                          onChanged: (value) {},
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Min & Max Salary
              Row(
                children: [
                  // Town
                  SizedBox(
                    width: (width / 2) - 30.0,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 10.0,
                        bottom: 10.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Min. Salary Amount (Monthly)",
                            style: GoogleFonts.dmSans(
                                textStyle: FontThemeData.inputLabel),
                          ),
                          const SizedBox(height: 2.0),
                          TextFormField(
                            style: const TextStyle(
                              color: Colors.black,
                              decorationColor: Colors.black,
                            ),
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 5.0, horizontal: 5.0),
                              filled: true,
                              fillColor: Colors.white,
                              hintStyle: const TextStyle(
                                  color: Colors.grey, fontSize: 15.0),
                              enabledBorder: InputsThemeData.inputForm,
                              focusedBorder: InputsThemeData.inputFormSelected,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 20.0),
                  // City
                  SizedBox(
                    width: (width / 2) - 30.0,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 10.0,
                        bottom: 10.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Max. Salary Amount (Monthly)",
                            style: GoogleFonts.dmSans(
                                textStyle: FontThemeData.inputLabel),
                          ),
                          const SizedBox(height: 2.0),
                          TextFormField(
                            style: const TextStyle(
                              color: Colors.black,
                              decorationColor: Colors.black,
                            ),
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 5.0, horizontal: 5.0),
                              filled: true,
                              fillColor: Colors.white,
                              hintStyle: const TextStyle(
                                  color: Colors.grey, fontSize: 15.0),
                              enabledBorder: InputsThemeData.inputForm,
                              focusedBorder: InputsThemeData.inputFormSelected,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              // Job Type
              SizedBox(
                width: width - 40.0,
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 10.0,
                    bottom: 10.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Job Type",
                        style: GoogleFonts.dmSans(
                            textStyle: FontThemeData.inputLabel),
                      ),
                      const SizedBox(height: 2.0),
                      Container(
                        width: width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: const Color.fromRGBO(51, 65, 85, 1.0)
                                .withOpacity(0.2),
                            width: 2.0,
                          ),
                        ),
                        child: DropdownButton(
                          isExpanded: true,
                          items: jobTypes.map((String type) {
                            return DropdownMenuItem(
                              value: type,
                              child: Text(type),
                            );
                          }).toList(),
                          onChanged: (value) {},
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Skills
              SizedBox(
                width: width - 40.0,
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 10.0,
                    bottom: 10.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Skills",
                        style: GoogleFonts.dmSans(
                            textStyle: FontThemeData.inputLabel),
                      ),
                      const SizedBox(height: 2.0),
                      SizedBox(
                        width: width,
                        child: Wrap(
                          spacing: 10.0,
                          direction: Axis.horizontal,
                          children: [
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromRGBO(93, 216, 171, 1.0),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Internship",
                                    softWrap: true,
                                    style: GoogleFonts.dmSans(
                                        textStyle: FontThemeData.btnBlackText),
                                  ),
                                  const SizedBox(width: 8.0),
                                  const Icon(
                                    Icons.close,
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                primary:
                                    const Color.fromRGBO(93, 216, 171, 1.0),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "CSS",
                                    softWrap: true,
                                    style: GoogleFonts.dmSans(
                                        textStyle: FontThemeData.btnBlackText),
                                  ),
                                  const SizedBox(width: 8.0),
                                  const Icon(
                                    Icons.close,
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.add),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Description
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Description",
                    style:
                        GoogleFonts.dmSans(textStyle: FontThemeData.inputLabel),
                  ),
                  TextField(
                    maxLines: 10,
                    maxLength: 500,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: InputsThemeData.inputForm,
                      focusedBorder: InputsThemeData.inputFormSelected,
                      isDense: true,
                    ),
                    enableSuggestions: true,
                  ),
                ],
              ),
              // Job Type
              SizedBox(
                width: width - 40.0,
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 10.0,
                    bottom: 10.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Job Active Duration",
                        style: GoogleFonts.dmSans(
                            textStyle: FontThemeData.inputLabel),
                      ),
                      const SizedBox(height: 2.0),
                      Container(
                        width: width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: const Color.fromRGBO(51, 65, 85, 1.0)
                                .withOpacity(0.2),
                            width: 2.0,
                          ),
                        ),
                        child: DropdownButton(
                          isExpanded: true,
                          items: jobDurations.map((String duration) {
                            return DropdownMenuItem(
                              value: duration,
                              child: Text(duration),
                            );
                          }).toList(),
                          onChanged: (value) {},
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 80.0),
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
                    const Icon(Icons.post_add_outlined, size: 15.0),
                    const SizedBox(width: 5.0),
                    Text(
                      "POST A JOB",
                      style:
                          GoogleFonts.dmSans(textStyle: FontThemeData.btnText),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 5.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: const Color.fromRGBO(185, 185, 185, 1.0),
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
                child: Text(
                  "CANCEL",
                  style: GoogleFonts.dmSans(textStyle: FontThemeData.btnText),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
