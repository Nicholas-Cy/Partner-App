import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../theme_data/fonts.dart';
import '../theme_data/inputs.dart';
import '../../data/auth.dart';
import '../../types/register_partner.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  RegisterPartner _registerPartner = RegisterPartner(
    id: 0,
    email: '',
    password: '',
    passwordConfirmation: '',
    companyName: '',
    displayName: '',
    employeeCount: '< 10',
    bio: '',
  );
  final companySizes = [
    '< 10',
    '10 - 20',
    '50 - 100',
    '100 - 500',
    '500 - 1000',
    '1000+'
  ];
  String msg = '';

  Future<void> submitForm(BuildContext context) async {
    // ignore: use_build_context_synchronously
    await Provider.of<AuthProvider>(context, listen: false)
        .register(_registerPartner)
        .then((value) => {
              if (value)
                {
                  setState(() {
                    msg =
                        'Your account has been created, and a verification token has been sent.';
                  }),
                }
              else
                {
                  setState(() {
                    msg = 'Sorry, couldn\'t create your account.';
                  }),
                }
            });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
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
              scrollDirection: Axis.vertical,
              child: Form(
                key: _formKey,
                child: Container(
                  transform: Matrix4.translationValues(0.0, -80.0, 0.0),
                  padding: const EdgeInsets.symmetric(horizontal: 35.0),
                  color: Colors.transparent,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 210.0),
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
                          child: Text("PARTNER | REGISTER",
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
                          onSaved: (value) => _registerPartner.email = value!,
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
                          onSaved: (value) =>
                              _registerPartner.password = value!,
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
                        padding: const EdgeInsets.only(
                          bottom: 20.0,
                        ),
                        child: TextFormField(
                          validator: (value) => value!.isEmpty
                              ? 'Enter your password confirmation'
                              : null,
                          onSaved: (value) =>
                              _registerPartner.passwordConfirmation = value!,
                          style: const TextStyle(
                            color: Colors.white,
                            decorationColor: Colors.black,
                          ),
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 5.0),
                            hintText: 'Password Confirmation',
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
                        padding: const EdgeInsets.only(
                          bottom: 20.0,
                        ),
                        child: TextFormField(
                          validator: (value) =>
                              value!.isEmpty ? 'Enter your company name' : null,
                          onSaved: (value) =>
                              _registerPartner.companyName = value!,
                          style: const TextStyle(
                            color: Colors.white,
                            decorationColor: Colors.black,
                          ),
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 5.0),
                            hintText: 'Company Name',
                            filled: true,
                            fillColor: Colors.black.withOpacity(0.25),
                            prefixIcon: const Icon(Icons.text_format_outlined,
                                color: Colors.white),
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
                              value!.isEmpty ? 'Enter your display name' : null,
                          onSaved: (value) =>
                              _registerPartner.displayName = value!,
                          style: const TextStyle(
                            color: Colors.white,
                            decorationColor: Colors.black,
                          ),
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 5.0),
                            hintText: 'Display Name',
                            filled: true,
                            fillColor: Colors.black.withOpacity(0.25),
                            prefixIcon: const Icon(Icons.text_format_outlined,
                                color: Colors.white),
                            hintStyle: const TextStyle(
                                color: Colors.white30, fontSize: 15.0),
                            enabledBorder: InputsThemeData.inputBorder,
                            focusedBorder: InputsThemeData.inputBorderSelected,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: Container(
                          width: width,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.25),
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(
                              color: Colors.white,
                              width: 1.0,
                            ),
                          ),
                          child: DropdownButton(
                            value: _registerPartner.employeeCount,
                            isExpanded: true,
                            dropdownColor: Colors.black.withOpacity(0.25),
                            items: companySizes.map((String range) {
                              return DropdownMenuItem(
                                value: range,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5.0, horizontal: 10.0),
                                  child: Text(
                                    range,
                                    style: GoogleFonts.dmSans(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              _registerPartner.employeeCount = value.toString();
                              setState(() {
                                _registerPartner = _registerPartner;
                              });
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: 20.0,
                        ),
                        child: TextFormField(
                          validator: (value) =>
                              value!.isEmpty ? 'Enter your bio' : null,
                          onSaved: (value) => _registerPartner.bio = value!,
                          style: const TextStyle(
                            color: Colors.white,
                            decorationColor: Colors.black,
                          ),
                          maxLines: 5,
                          maxLength: 500,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 10.0),
                            hintText: 'Bio',
                            filled: true,
                            fillColor: Colors.black.withOpacity(0.25),
                            hintStyle: const TextStyle(
                                color: Colors.white30, fontSize: 15.0),
                            enabledBorder: InputsThemeData.inputBorder,
                            focusedBorder: InputsThemeData.inputBorderSelected,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: (msg.isNotEmpty)
                            ? Text(
                                msg,
                                style: GoogleFonts.dmSans(
                                  color: Colors.white,
                                ),
                              )
                            : const SizedBox(),
                      ),
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
                          "REGISTER",
                          softWrap: true,
                          style: GoogleFonts.dmSans(
                            textStyle: FontThemeData.btnBlackText,
                          ),
                        ),
                      ),
                      const SizedBox(height: 50.0),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
