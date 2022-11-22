import 'package:beamcoda_jobs_partners_flutter/data/job.dart';
import 'package:beamcoda_jobs_partners_flutter/data/subscription.dart';
import 'package:beamcoda_jobs_partners_flutter/ui/authentication/login.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'firebase_options.dart';

import './data/auth.dart';
import 'ui/authentication/login.dart';
import './ui/layout.dart';

String? fcmToken;

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
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  fcmToken = await FirebaseMessaging.instance.getToken();
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<JobProvider>(create: (context) => JobProvider()),
        ChangeNotifierProvider<SubscriptionProvider>(
            create: (context) => SubscriptionProvider()),
      ],
      child: MaterialApp(
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
      ),
    );
  }
}
