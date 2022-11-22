import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme_data/fonts.dart';
import '../theme_data/inputs.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final companySizes = [
    '< 10',
    '10 - 20',
    '50 - 100',
    '100 - 500',
    '500 - 1000',
    '1000+'
  ];

  @override
  Widget build(BuildContext context) {
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
                  child: const Image(
                    width: 20.0,
                    image: AssetImage('assets/images/logo.png'),
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
                        "Short name",
                        style: GoogleFonts.dmSans(
                            textStyle: FontThemeData.inputLabel),
                      ),
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
                // Company Bio
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Short Bio",
                      style: GoogleFonts.dmSans(
                          textStyle: FontThemeData.inputLabel),
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
                          child: DropdownButton(
                            isExpanded: true,
                            items: companySizes.map((String size) {
                              return DropdownMenuItem(
                                value: size,
                                child: Text(size),
                              );
                            }).toList(),
                            onChanged: (value) {},
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                // Locations
                Text(
                  "Locations",
                  style: GoogleFonts.dmSans(
                      textStyle: FontThemeData.profilePageSecondaryTitle),
                ),
                const SizedBox(height: 10.0),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      constraints: BoxConstraints(minWidth: width - 100.0),
                      height: 40.0,
                      child: ListView.builder(
                        clipBehavior: Clip.hardEdge,
                        scrollDirection: Axis.horizontal,
                        itemCount: 2,
                        shrinkWrap: true,
                        itemBuilder: (_, i) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 15.0),
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(231, 231, 231, 1.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 5.0,
                                  ),
                                ],
                              ),
                              child: Text(
                                "S.A., California",
                                style: GoogleFonts.dmSans(
                                    textStyle: FontThemeData.resumeTitle),
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.add_circle,
                        size: 40.0,
                        color: Color.fromRGBO(21, 192, 182, 1.0),
                      ),
                    ),
                  ],
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
