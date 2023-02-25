import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../components/main/switch.dart';
import '../../../logic/cubit/theme_cubit.dart';
import '../../theme_data/fonts.dart';

class AppearancePage extends StatelessWidget {
  const AppearancePage({super.key});

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
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            ),
            const SizedBox(width: 10.0),
            Text(
              "PARTNER",
              style: GoogleFonts.dmSans(
                textStyle: FontThemeData.partnerHeading,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
        toolbarHeight: 80.0,
        elevation: 0,
        backgroundColor: Theme.of(context).backgroundColor,
        shadowColor: Colors.transparent,
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
      ),
      body: BlocBuilder<SwitchCubit, SwitchState>(
        builder: (context, state) => SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            color: Theme.of(context).backgroundColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                const SizedBox(height: 15.0),
                SizedBox(
                  width: width - 40.0,
                  child: Text(
                    "App Theme",
                    style: GoogleFonts.dmSans(
                      textStyle: FontThemeData.sectionTitles,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                const SizedBox(height: 30.0),
                // Dark mode
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: width - 100.0,
                      child: Text(
                        "Dark Mode",
                        style: GoogleFonts.dmSans(
                          textStyle: FontThemeData.settingsListItemPrimary,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                      child: CustomToggleSwitch(
                        key: UniqueKey(),
                        value: context.read<SwitchCubit>().state.isDarkThemeOn,
                        onChange: () {
                          context.read<SwitchCubit>().toggleSwitch(
                              !context.read<SwitchCubit>().state.isDarkThemeOn);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
