import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../data/auth.dart';
import '../../../data/job.dart';
import '../../../types/category.dart';
import '../../../types/edit_post.dart';
import '../../../types/job_types.dart';
import '../../../types/skill.dart';
import '../../../utils/constants.dart';
import '../../theme_data/fonts.dart';
import '../../theme_data/inputs.dart';

class EditJobPost extends StatefulWidget {
  final int id;
  final Function callback;
  const EditJobPost(
      {required Key key, required this.id, required this.callback})
      : super(key: key);

  @override
  State<EditJobPost> createState() => _EditJobPostState();
}

class _EditJobPostState extends State<EditJobPost> {
  late EditPost editPost;
  bool isLoaded = false;

  Future<void> initJob(BuildContext ctx) async {
    final jobProvider = Provider.of<JobProvider>(ctx, listen: false);
    final userProvider = Provider.of<AuthProvider>(ctx, listen: false);
    String? token = await userProvider.getToken();
    jobProvider.jobSkills.clear();
    final Uri url = Uri.parse(
        "${AppConstants.API_URL}${AppConstants.JOBS_RETRIEVAL}/${widget.id}");
    final response = await http.get(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      EditPost newEditPost = EditPost.fromJson(data["data"]);
      setState(() {
        isLoaded = true;
        editPost = newEditPost;
      });
      List<Skill> skills = data["data"]["skills"]
          .map<Skill>((item) => Skill.fromJson(item))
          .toList();
      for (var item in skills) {
        jobProvider.addSkillToList(item);
      }

      return;
    } else {
      throw Exception('Problem loading job information.');
    }
  }

  @override
  void initState() {
    super.initState();
    initJob(context);
  }

  Future<void> saveJob(BuildContext ctx) async {
    final userProvider = Provider.of<AuthProvider>(ctx, listen: false);
    final jobProvider = Provider.of<JobProvider>(ctx, listen: false);
    String? token = await userProvider.getToken();

    final Uri url = Uri.parse(
        "${AppConstants.API_URL}${AppConstants.EDIT_JOB}/${widget.id}");
    String skillsList =
        jobProvider.jobSkills.map((skill) => skill.id).toString();
    skillsList = skillsList.substring(1, skillsList.length - 1);
    final response = await http.post(
      url,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode({
        'partner_id': editPost.partnerId,
        'job_title': editPost.title,
        'is_remote': editPost.isRemote,
        'city': editPost.city,
        'country': editPost.country,
        'category_id': editPost.category,
        'no_pay_range': editPost.noPayRange,
        'min_salary_range': editPost.minSalary,
        'max_salary_range': editPost.maxSalary,
        'job_type_id': editPost.jobType,
        'desc': editPost.desc,
        'skills': skillsList,
        'is_published': editPost.isPublished,
        'status': editPost.status,
      }),
    );
    if (response.statusCode == 200) {
      jobProvider.jobSkills.clear();
      // ignore: use_build_context_synchronously
      widget.callback();
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
    } else {
      throw Exception("Couldn't save job post.");
    }
  }

  showAlertSkillList(BuildContext context) {
    final jobProvider = Provider.of<JobProvider>(context, listen: false);

    // Remove skills on list
    Future<List<Skill>> loadListAfterClear() async {
      final List<Skill> skillList = jobProvider.skills;
      for (var item in jobProvider.jobSkills) {
        skillList.removeWhere((element) => element.id == item.id);
      }
      return skillList;
    }

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Center(child: Text("Add Skill to Job Post")),
      titleTextStyle:
          GoogleFonts.dmSans(textStyle: FontThemeData.jobPostSecondHeadingBold),
      actions: [
        SizedBox(
          width: 250.0,
          height: 180.0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 200.0,
                child: FutureBuilder<List<Skill>>(
                  future: loadListAfterClear(),
                  builder: (context, future) {
                    if (!future.hasData) {
                      return const Text('No Skills Found.');
                    } else {
                      List<Skill>? skills = future.data;
                      if (skills!.isEmpty) {
                        return const Text('No Skills Found.');
                      }
                      return ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: skills.length,
                        shrinkWrap: true,
                        itemBuilder: (_, i) {
                          return Center(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.teal.shade400,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(2.0),
                                ),
                              ),
                              child: Text(skills[i].name,
                                  style: GoogleFonts.dmSans()),
                              onPressed: () {
                                jobProvider.addSkillToList(skills[i]);
                                Navigator.of(context).pop();
                              },
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final jobProvider = Provider.of<JobProvider>(context);
    final List<Category> industryTypes = jobProvider.categories;
    final List<JobType> jobTypes = jobProvider.jobTypes;
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
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            ),
            const SizedBox(width: 10.0),
            Text(
              "PARTNER",
              style: GoogleFonts.dmSans(
                  textStyle: FontThemeData.partnerHeading,
                  color: Theme.of(context).primaryColor),
            ),
          ],
        ),
        toolbarHeight: 80.0,
        elevation: 0,
        backgroundColor: Theme.of(context).backgroundColor,
        shadowColor: Colors.transparent,
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: (isLoaded)
          ? SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 20.0),
                color: Theme.of(context).backgroundColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 5.0),
                    Text(
                      "Edit job",
                      style: GoogleFonts.dmSans(
                          textStyle: FontThemeData.sectionTitleSecondary,
                          color: Theme.of(context).primaryColor),
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
                                textStyle: FontThemeData.inputLabel,
                                color: Theme.of(context).primaryColor),
                          ),
                          const SizedBox(height: 2.0),
                          TextFormField(
                            initialValue: editPost.title,
                            onChanged: (value) {
                              editPost.title = value;
                              setState(() {
                                editPost = editPost;
                              });
                            },
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
                    // Remote Work Checkbox
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Checkbox(
                          value: editPost.isRemote,
                          onChanged: (value) {
                            editPost.isRemote = value!;
                            setState(() {
                              editPost = editPost;
                            });
                          },
                        ),
                        Text(
                          "This position is remote",
                          style: GoogleFonts.dmSans(
                              textStyle: FontThemeData.btnBlackText,
                              color: Theme.of(context).primaryColor),
                        ),
                      ],
                    ),
                    //City & Country
                    (editPost.isRemote == false)
                        ? Row(
                            children: [
                              // City
                              SizedBox(
                                width: (width / 2) - 30.0,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    top: 10.0,
                                    bottom: 10.0,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "City",
                                        style: GoogleFonts.dmSans(
                                            textStyle: FontThemeData.inputLabel,
                                            color:
                                                Theme.of(context).primaryColor),
                                      ),
                                      const SizedBox(height: 2.0),
                                      TextFormField(
                                        initialValue: editPost.city,
                                        onChanged: (value) {
                                          editPost.city = value;
                                          setState(() {
                                            editPost = editPost;
                                          });
                                        },
                                        style: const TextStyle(
                                          color: Colors.black,
                                          decorationColor: Colors.black,
                                        ),
                                        keyboardType: TextInputType.name,
                                        decoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 5.0,
                                                  horizontal: 5.0),
                                          filled: true,
                                          fillColor: Colors.white,
                                          hintStyle: const TextStyle(
                                              color: Colors.grey,
                                              fontSize: 15.0),
                                          enabledBorder:
                                              InputsThemeData.inputForm,
                                          focusedBorder:
                                              InputsThemeData.inputFormSelected,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20.0),
                              // Country
                              SizedBox(
                                width: (width / 2) - 30.0,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    top: 10.0,
                                    bottom: 10.0,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Country",
                                        style: GoogleFonts.dmSans(
                                            textStyle: FontThemeData.inputLabel,
                                            color:
                                                Theme.of(context).primaryColor),
                                      ),
                                      const SizedBox(height: 2.0),
                                      TextFormField(
                                        initialValue: editPost.country,
                                        onChanged: (value) {
                                          editPost.country = value;
                                          setState(() {
                                            editPost = editPost;
                                          });
                                        },
                                        style: const TextStyle(
                                          color: Colors.black,
                                          decorationColor: Colors.black,
                                        ),
                                        keyboardType: TextInputType.name,
                                        decoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 5.0,
                                                  horizontal: 5.0),
                                          filled: true,
                                          fillColor: Colors.white,
                                          hintStyle: const TextStyle(
                                              color: Colors.grey,
                                              fontSize: 15.0),
                                          enabledBorder:
                                              InputsThemeData.inputForm,
                                          focusedBorder:
                                              InputsThemeData.inputFormSelected,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        : const SizedBox(),
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
                                  textStyle: FontThemeData.inputLabel,
                                  color: Theme.of(context).primaryColor),
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
                              child: DropdownButton<int>(
                                value: editPost.category,
                                isExpanded: true,
                                items: industryTypes
                                    .map<DropdownMenuItem<int>>((type) {
                                  return DropdownMenuItem<int>(
                                    value: type.id,
                                    child: Text(type.name),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  editPost.category = value!;
                                  setState(() {
                                    editPost = editPost;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // No Pay Range Checkbox
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Checkbox(
                          value: editPost.noPayRange,
                          onChanged: (value) {
                            editPost.noPayRange = value!;
                            setState(() {});
                          },
                        ),
                        Text(
                          "No Pay Range",
                          style: GoogleFonts.dmSans(
                              textStyle: FontThemeData.btnBlackText,
                              color: Theme.of(context).primaryColor),
                        ),
                      ],
                    ),
                    // Min & Max Salary
                    (editPost.noPayRange == false)
                        ? Row(
                            children: [
                              // Min Salary
                              SizedBox(
                                width: (width / 2) - 30.0,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    top: 10.0,
                                    bottom: 10.0,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Min. Salary Amount (Annual)",
                                        style: GoogleFonts.dmSans(
                                            textStyle: FontThemeData.inputLabel,
                                            color:
                                                Theme.of(context).primaryColor),
                                      ),
                                      const SizedBox(height: 2.0),
                                      TextFormField(
                                        initialValue:
                                            editPost.minSalary.toString(),
                                        onChanged: (value) {
                                          editPost.minSalary = int.parse(value);
                                          setState(() {
                                            editPost = editPost;
                                          });
                                        },
                                        style: const TextStyle(
                                          color: Colors.black,
                                          decorationColor: Colors.black,
                                        ),
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        decoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 5.0,
                                                  horizontal: 5.0),
                                          filled: true,
                                          fillColor: Colors.white,
                                          hintStyle: const TextStyle(
                                              color: Colors.grey,
                                              fontSize: 15.0),
                                          enabledBorder:
                                              InputsThemeData.inputForm,
                                          focusedBorder:
                                              InputsThemeData.inputFormSelected,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20.0),
                              // Max Salary
                              SizedBox(
                                width: (width / 2) - 30.0,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    top: 10.0,
                                    bottom: 10.0,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Max. Salary Amount (Annual)",
                                        style: GoogleFonts.dmSans(
                                            textStyle: FontThemeData.inputLabel,
                                            color:
                                                Theme.of(context).primaryColor),
                                      ),
                                      const SizedBox(height: 2.0),
                                      TextFormField(
                                        initialValue:
                                            editPost.maxSalary.toString(),
                                        onChanged: (value) {
                                          editPost.maxSalary = int.parse(value);
                                          setState(() {
                                            editPost = editPost;
                                          });
                                        },
                                        style: const TextStyle(
                                          color: Colors.black,
                                          decorationColor: Colors.black,
                                        ),
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        decoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 5.0,
                                                  horizontal: 5.0),
                                          filled: true,
                                          fillColor: Colors.white,
                                          hintStyle: const TextStyle(
                                              color: Colors.grey,
                                              fontSize: 15.0),
                                          enabledBorder:
                                              InputsThemeData.inputForm,
                                          focusedBorder:
                                              InputsThemeData.inputFormSelected,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        : const SizedBox(),
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
                                  textStyle: FontThemeData.inputLabel,
                                  color: Theme.of(context).primaryColor),
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
                              child: DropdownButton<int>(
                                value: editPost.jobType,
                                isExpanded: true,
                                items:
                                    jobTypes.map<DropdownMenuItem<int>>((type) {
                                  return DropdownMenuItem<int>(
                                    value: type.id,
                                    child: Text(type.name),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  editPost.jobType = value!;
                                  setState(() {});
                                },
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
                                  textStyle: FontThemeData.inputLabel,
                                  color: Theme.of(context).primaryColor),
                            ),
                            const SizedBox(height: 2.0),
                            SizedBox(
                              width: width,
                              child: Wrap(
                                spacing: 10.0,
                                direction: Axis.horizontal,
                                children: [
                                  (jobProvider.jobSkills.isNotEmpty)
                                      ? Container(
                                          width: width - 40.0,
                                          constraints: const BoxConstraints(
                                              minHeight: 60.0,
                                              maxHeight: 200.0),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10.0),
                                          child: ListView.builder(
                                            itemCount:
                                                jobProvider.jobSkills.length,
                                            shrinkWrap: true,
                                            itemBuilder: (_, i) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 8.0),
                                                child: ElevatedButton(
                                                  onPressed: () {},
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        const Color.fromRGBO(
                                                            93, 216, 171, 1.0),
                                                  ),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Text(
                                                        jobProvider
                                                            .jobSkills[i].name,
                                                        softWrap: true,
                                                        style: GoogleFonts.dmSans(
                                                            textStyle:
                                                                FontThemeData
                                                                    .btnBlackText),
                                                      ),
                                                      const SizedBox(
                                                          width: 8.0),
                                                      GestureDetector(
                                                        onTap: () {
                                                          jobProvider
                                                              .removeSkillFromList(
                                                                  jobProvider
                                                                      .jobSkills[i]);
                                                          jobProvider
                                                              .loadSkills(
                                                                  context);
                                                        },
                                                        child: const Icon(
                                                          Icons.close,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        )
                                      : Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 13.0),
                                          child: Text(
                                            "No Skills Added",
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor),
                                          ),
                                        ),
                                  Center(
                                    child: IconButton(
                                      onPressed: () {
                                        showAlertSkillList(context);
                                      },
                                      icon: Icon(Icons.add,
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
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
                          style: GoogleFonts.dmSans(
                              textStyle: FontThemeData.inputLabel,
                              color: Theme.of(context).primaryColor),
                        ),
                        TextFormField(
                          initialValue: editPost.desc,
                          onChanged: (value) {
                            editPost.desc = value;
                            setState(() {
                              editPost = editPost;
                            });
                          },
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
                    const SizedBox(height: 80.0),
                  ],
                ),
              ),
            )
          : const SizedBox(),
      bottomSheet: Container(
        width: width,
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              width: 2.0,
              color: Colors.black.withOpacity(0.25),
            ),
          ),
          color: Theme.of(context).backgroundColor,
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
                onPressed: () {
                  saveJob(context);
                },
                child: Row(
                  children: [
                    const Icon(Icons.post_add_outlined,
                        size: 15.0, color: Colors.white),
                    const SizedBox(width: 5.0),
                    Text(
                      "UPDATE JOB",
                      style:
                          GoogleFonts.dmSans(textStyle: FontThemeData.btnText),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 5.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: const Color.fromRGBO(185, 185, 185, 1.0),
                  backgroundColor: const Color.fromRGBO(185, 185, 185, 1.0),
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
