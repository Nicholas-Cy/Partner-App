import 'package:beamcoda_jobs_partners_flutter/ui/layout.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import './data/auth.dart';
import './ui/authentication/login.dart';
import './ui/layout.dart';

Future<void> main() async {
  // Register google_fonts license (DM Sans)
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/dmsans/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/raleway/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ChangeNotifierProvider(
      create: (BuildContext context) => AuthProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BeemCoda Jobs Partner',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.dmSansTextTheme(),
      ),
      home: Consumer<AuthProvider>(builder: (context, auth, child) {
        switch (auth.isAuthenticated) {
          case false:
            return const LoginPage();
          default:
            return LayoutPage(key: GlobalKey());
        }
      }),
    );
  }
}
