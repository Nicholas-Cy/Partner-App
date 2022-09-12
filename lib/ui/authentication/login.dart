import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme_data/fonts.dart';
import '../theme_data/inputs.dart';
import '../homepage/index.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        color: Colors.white,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            // BG Splash
            Positioned(
              top: 100.0,
              child: Image(
                width: width + 200.0,
                fit: BoxFit.cover,
                image: const AssetImage(
                    'assets/illustrations/partner-app-login-bg.png'),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                transform: Matrix4.translationValues(0.0, -80.0, 0.0),
                height: height,
                padding: const EdgeInsets.symmetric(horizontal: 35.0),
                color: Colors.transparent,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Image(
                      width: 80.0,
                      fit: BoxFit.contain,
                      image: AssetImage('assets/images/logo.png'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 30.0,
                        bottom: 10.0,
                      ),
                      child: DefaultTextStyle(
                        style: GoogleFonts.dmSans(
                          textStyle: FontThemeData.authHeading,
                        ),
                        child: Text("PARTNER | LOGIN",
                            softWrap: true,
                            style: GoogleFonts.dmSans(
                                textStyle: FontThemeData.btnText)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      child: TextFormField(
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 5.0),
                          hintText: 'Email',
                          filled: true,
                          fillColor: Colors.black.withOpacity(0.25),
                          prefixIcon:
                              const Icon(Icons.email, color: Colors.white),
                          hintStyle: const TextStyle(
                              color: Colors.white30, fontSize: 15.0),
                          enabledBorder: InputsThemeData.inputBorder,
                          focusedBorder: InputsThemeData.inputBorderSelected,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 20.0,
                      ),
                      child: TextFormField(
                        style: const TextStyle(
                          color: Colors.white,
                          decorationColor: Colors.black,
                        ),
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 5.0),
                          hintText: 'Password',
                          filled: true,
                          fillColor: Colors.black.withOpacity(0.25),
                          prefixIcon:
                              const Icon(Icons.password, color: Colors.white),
                          hintStyle: const TextStyle(
                              color: Colors.white30, fontSize: 15.0),
                          enabledBorder: InputsThemeData.inputBorder,
                          focusedBorder: InputsThemeData.inputBorderSelected,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const HomePage();
                        }));
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30.0,
                          vertical: 10.0,
                        ),
                        primary: const Color.fromRGBO(255, 255, 255, 1.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            10.0,
                          ),
                        ),
                      ),
                      child: Text(
                        "LOGIN",
                        softWrap: true,
                        style: GoogleFonts.dmSans(
                          textStyle: FontThemeData.btnBlackText,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Positioned(
              bottom: 30.0,
              child: Text("Register"),
            ),
          ],
        ),
      ),
    );
  }
}
