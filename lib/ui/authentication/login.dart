import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/auth.dart';
import '../theme_data/fonts.dart';
import '../theme_data/inputs.dart';
import '../../ui/authentication/register.dart';
import '../../utils/constants.dart';
import '../layout.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  late String _email;
  late String _password;
  String errorMessage = '';

  Future<void> submitForm(BuildContext context) async {
    setState(() {
      errorMessage = '';
    });
    // ignore: use_build_context_synchronously
    String result = await Provider.of<AuthProvider>(context, listen: false)
        .login(_email, _password);
    if (result != '') {
      setState(() {
        errorMessage = result;
      });
    } else {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return LayoutPage(key: GlobalKey());
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: _formKey,
        child: Container(
          color: Colors.black,
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
                      const SizedBox(height: 200.0),
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
                          validator: (value) => value!.isEmpty
                              ? 'Please enter an email address'
                              : null,
                          onSaved: (value) => _email = value!,
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
                          validator: (value) =>
                              value!.isEmpty ? 'Enter your password' : null,
                          onSaved: (value) => _password = value!,
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
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: SizedBox(
                          width: width,
                          child: InkWell(
                            onTap: () {
                              launchUrl(Uri.parse(
                                  "${AppConstants.STATIC_WEB_URL}/partner/forgot-password"));
                            },
                            child: Text(
                              "Forgot Password?",
                              style: GoogleFonts.dmSans(
                                  textStyle: FontThemeData.btnText),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                      ),
                      (errorMessage != '')
                          ? Text(
                              errorMessage,
                              softWrap: true,
                              style: GoogleFonts.dmSans(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : const SizedBox(),
                      const SizedBox(height: 10.0),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            submitForm(context);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30.0,
                            vertical: 10.0,
                          ),
                          backgroundColor:
                              const Color.fromRGBO(255, 255, 255, 1.0),
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
                      const SizedBox(height: 100.0),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return Register(
                                  key: UniqueKey(),
                                );
                              },
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            elevation: 0.0),
                        child: Container(
                          width: 125.0,
                          height: 50.0,
                          decoration: const BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: Colors.black,
                            borderRadius: BorderRadius.all(
                              Radius.circular(40.0),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "Register",
                              style: GoogleFonts.dmSans(),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
