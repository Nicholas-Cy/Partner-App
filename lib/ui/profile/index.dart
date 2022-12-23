import 'dart:convert';
import 'dart:io';

import 'package:beamcoda_jobs_partners_flutter/data/auth.dart';
import 'package:beamcoda_jobs_partners_flutter/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../theme_data/fonts.dart';
import '../theme_data/inputs.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File image = File('');
  final picker = ImagePicker();
  final companySizes = [
    '< 10',
    '10 - 20',
    '50 - 100',
    '100 - 500',
    '500 - 1000',
    '1000+'
  ];
  String msg = '';

  @override
  void initState() {
    super.initState();
    msg = '';
  }

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
      } else {
        throw Exception('No image selected.');
      }
    });
  }

  Future<Widget> buildImage() async {
    bool exists = await image.exists();
    if (!exists) {
      return const Padding(
        padding: EdgeInsets.fromLTRB(1, 1, 1, 1),
        child: Icon(
          Icons.add,
          color: Colors.grey,
        ),
      );
    } else {
      return Text(image.path);
    }
  }

  Future<String> uploadImage(File img) async {
    final userProvider = Provider.of<AuthProvider>(context, listen: false);
    String? token = await userProvider.getToken();
    Map<String, String> headers = {
      'Content-Type': 'multipart/form-data',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.MultipartRequest('POST',
        Uri.parse("${AppConstants.API_URL}${AppConstants.UPLOAD_IMG_URL}"))
      ..headers.addAll(headers)
      ..files.add(await http.MultipartFile.fromPath('image', img.path));
    var response = await request.send();
    if (response.statusCode == 200) {
      final responseString = await response.stream.bytesToString();
      Map<String, dynamic> data = json.decode(responseString);
      return data['data']['file_name'];
    } else {
      throw Exception('Couldn\'t upload the profile picture.');
    }
  }

  Future<void> saveProfile(BuildContext ctx) async {
    final userProvider = Provider.of<AuthProvider>(ctx, listen: false);
    String? token = await userProvider.getToken();
    late String imgUrl;

    if (image.path != '') {
      String res = await uploadImage(image);
      imgUrl =
          "${AppConstants.API_URL}${AppConstants.UPLOAD_IMG_DIRECTORY}/$res";
    }

    final partnerId = userProvider.partner.id;
    final Uri url = Uri.parse(
        "${AppConstants.API_URL}${AppConstants.PARTNER_SAVE_PROFILE}/$partnerId");
    final response = await http.put(
      url,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode({
        'img_url': (image.path == '') ? userProvider.partner.img : imgUrl,
        'company_name': userProvider.partner.name,
        'short_name': userProvider.partner.displayName,
        'bio': userProvider.partner.bio,
        'employee_count': userProvider.partner.empCount
      }),
    );
    if (response.statusCode == 200) {
      // ignore: use_build_context_synchronously
      await userProvider.getUserDetails(context);
      setState(() {
        msg = 'Profile Information Saved.';
      });
      return;
    } else {
      throw Exception("Couldn't update user profile.");
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    double width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        color: const Color.fromRGBO(248, 248, 248, 1.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10.0),
            Row(
              children: <Widget>[
                Container(
                  width: 100.0,
                  height: 100.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(
                      width: 1,
                      style: BorderStyle.solid,
                      color: const Color.fromRGBO(216, 216, 216, 1.0),
                    ),
                    color: Colors.white,
                  ),
                  child: GestureDetector(
                    onTap: () async {
                      await getImage();
                    },
                    child: (image.path == '')
                        ? Image(
                            width: 20.0,
                            image: NetworkImage(authProvider.partner.img,
                                headers: {'Keep-Alive': 'timeout=5, max=1000'}),
                          )
                        : Image(
                            width: 20.0,
                            image: FileImage(image),
                          ),
                  ),
                ),
                const SizedBox(width: 10.0),
                SizedBox(
                  height: 100.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(height: 5.0),
                      SizedBox(
                        width: width - 150.0,
                        child: Text("Company Logo Picture",
                            style: GoogleFonts.dmSans(
                                textStyle:
                                    FontThemeData.profilePagePrimaryTitle)),
                      ),
                      const SizedBox(height: 5.0),
                      SizedBox(
                        width: width - 150.0,
                        child: Text(
                            "Tap the picture to upload a new image here.",
                            style: GoogleFonts.dmSans(
                                textStyle: FontThemeData.profilePageHintTxt)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10.0),
                Text(
                  "Personal",
                  style: GoogleFonts.dmSans(
                      textStyle: FontThemeData.profilePageSecondaryTitle),
                ),
                const SizedBox(height: 10.0),
                // Company Name (Legal)
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10.0,
                    bottom: 10.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Company Name (Legal)",
                        style: GoogleFonts.dmSans(
                            textStyle: FontThemeData.inputLabel),
                      ),
                      TextFormField(
                        style: const TextStyle(
                          color: Colors.black,
                          decorationColor: Colors.black,
                        ),
                        initialValue: authProvider.partner.name,
                        onChanged: (value) {
                          authProvider.partner.name = value;
                        },
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
                // Short Name
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 10.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Display name",
                        style: GoogleFonts.dmSans(
                            textStyle: FontThemeData.inputLabel),
                      ),
                      TextFormField(
                        style: const TextStyle(
                          color: Colors.black,
                          decorationColor: Colors.black,
                        ),
                        initialValue: authProvider.partner.displayName,
                        onChanged: (value) {
                          authProvider.partner.displayName = value;
                        },
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
                // Company Bio
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Bio",
                      style: GoogleFonts.dmSans(
                          textStyle: FontThemeData.inputLabel),
                    ),
                    TextFormField(
                      initialValue: authProvider.partner.bio,
                      onChanged: (value) {
                        authProvider.partner.bio = value;
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
                const SizedBox(height: 10.0),
                // Company Employee Size
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
                          "Company Employee Size",
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
                          child: DropdownButton<String>(
                            value: authProvider.partner.empCount,
                            isExpanded: true,
                            items: companySizes
                                .map<DropdownMenuItem<String>>((size) {
                              return DropdownMenuItem(
                                value: size,
                                child: Text(size),
                              );
                            }).toList(),
                            onChanged: (value) {
                              authProvider.partner.empCount = value!;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: (msg.isNotEmpty)
                      ? Text(
                          msg,
                          style: GoogleFonts.dmSans(
                            color: Colors.green,
                          ),
                        )
                      : const SizedBox(),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: const Color.fromRGBO(21, 192, 182, 1.0),
                    backgroundColor: const Color.fromRGBO(21, 192, 182, 1.0),
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 25.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        5.0,
                      ),
                    ),
                  ),
                  onPressed: () {
                    saveProfile(context);
                  },
                  child: Row(
                    children: [
                      const Icon(Icons.save, size: 15.0, color: Colors.white),
                      const SizedBox(width: 10.0),
                      Text(
                        "UPDATE PROFILE",
                        style: GoogleFonts.dmSans(
                            textStyle: FontThemeData.btnText),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50.0),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
