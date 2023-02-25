import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../data/auth.dart';
import '../types/job_applicant.dart';
import '../ui/theme_data/fonts.dart';
import '../utils/constants.dart';

class JobApplicantListItem extends StatefulWidget {
  final JobApplicant applicant;
  final Function callback;
  const JobApplicantListItem(
      {required Key key, required this.applicant, required this.callback})
      : super(key: key);

  @override
  State<JobApplicantListItem> createState() => _JobApplicantListItemState();
}

class _JobApplicantListItemState extends State<JobApplicantListItem> {
  late String _localPath;
  late bool _permissionReady;
  late TargetPlatform? platform;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      platform = TargetPlatform.android;
    } else {
      platform = TargetPlatform.iOS;
    }
  }

  Future<bool> _checkPermission() async {
    if (platform == TargetPlatform.android) {
      final status = await Permission.storage.status;
      if (status != PermissionStatus.granted) {
        final result = await Permission.storage.request();
        if (result == PermissionStatus.granted) {
          return true;
        }
      } else {
        return true;
      }
    } else {
      return true;
    }
    return false;
  }

  Future<void> _prepareSaveDir() async {
    _localPath = (await _findLocalPath())!;

    final savedDir = Directory(_localPath);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      await savedDir.create();
    }
  }

  Future<String?> _findLocalPath() async {
    if (platform == TargetPlatform.android) {
      return "/storage/emulated/0/Download";
    } else {
      var directory = await getApplicationDocumentsDirectory();
      return '${directory.path}${Platform.pathSeparator}Download';
    }
  }

  Future<void> shortlistCandidate(BuildContext ctx) async {
    final userProvider = Provider.of<AuthProvider>(ctx, listen: false);
    String? token = await userProvider.getToken();
    final Uri url = Uri.parse(
        "${AppConstants.API_URL}${AppConstants.SHORTLIST_APPLICANT}/${widget.applicant.id}");
    final response = await http.get(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });
    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception('Problem shortlisting candidate.');
    }
  }

  showAlertApplicantShortlist(BuildContext context) {
    // set up the buttons
    Widget consentBtn = ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.teal.shade400,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2.0),
        ),
      ),
      child: Text("Confirm", style: GoogleFonts.dmSans()),
      onPressed: () async {
        await shortlistCandidate(context).then((value) => {
              widget.callback(),
              Navigator.of(context).pop(),
            });
      },
    );
    Widget contactUsBtn = TextButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2.0),
            side: const BorderSide(color: Color.fromRGBO(226, 232, 240, 1.0))),
      ),
      child: Text("No, Exit", style: GoogleFonts.dmSans(color: Colors.black)),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Center(
          child: Text("Do you wish to shortlist ${widget.applicant.name}?")),
      titleTextStyle:
          GoogleFonts.dmSans(textStyle: FontThemeData.jobPostSecondHeadingBold),
      content: Text(
        "Applicant will be shortlisted for this position",
        style: GoogleFonts.dmSans(textStyle: FontThemeData.jobPostText),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            consentBtn,
            const SizedBox(width: 10.0),
            contactUsBtn,
          ],
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
    return Padding(
      padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
      child: InkWell(
        onTap: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                (widget.applicant.img.isNotEmpty)
                    ? Image(
                        image: NetworkImage(widget.applicant.img,
                            headers: {'Keep-Alive': 'timeout=5, max=1000'}),
                        width: 50.0,
                        height: 50.0,
                      )
                    : const SizedBox(),
                const SizedBox(width: 10.0),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.applicant.name,
                      style: GoogleFonts.dmSans(
                        textStyle: FontThemeData.profileName,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    const SizedBox(height: 2.0),
                    Text(
                      widget.applicant.profession,
                      style: GoogleFonts.dmSans(
                        textStyle: FontThemeData.profileOccupation,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            (widget.applicant.shortlisted)
                ? IconButton(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    onPressed: () async {
                      _permissionReady = await _checkPermission();
                      if (_permissionReady) {
                        await _prepareSaveDir();
                        try {
                          await Dio()
                              .download(widget.applicant.resumeLink,
                                  "$_localPath/${widget.applicant.resumeLink.split('/').last}")
                              .then((value) {
                            if (value.statusCode == 200) {
                              OpenFilex.open(
                                  "$_localPath/${widget.applicant.resumeLink.split('/').last}");
                            }
                          });
                        } catch (e) {
                          if (kDebugMode) {
                            print("Download Failed.\n\n$e");
                          }
                        }
                      }
                    },
                    icon: Icon(
                      Icons.file_download_outlined,
                      color: Theme.of(context).primaryColor,
                    ),
                  )
                : IconButton(
                    padding: const EdgeInsets.all(0.0),
                    onPressed: () {
                      showAlertApplicantShortlist(context);
                    },
                    icon: Icon(
                      Icons.list_alt_outlined,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
