import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../data/auth.dart';
import '../../../data/subscription.dart';
import '../../../ui/theme_data/fonts.dart';
import '../../../ui/theme_data/inputs.dart';
import '../../../utils/constants.dart';

class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }
    var buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 4 == 0 && nonZeroIndex != text.length) {
        buffer.write('  '); // Add double spaces.
      }
    }
    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: TextSelection.collapsed(offset: string.length));
  }
}

class PayInvoicePage extends StatefulWidget {
  final int id;
  const PayInvoicePage({required Key key, required this.id}) : super(key: key);

  @override
  State<PayInvoicePage> createState() => _PayInvoicePageState();
}

class _PayInvoicePageState extends State<PayInvoicePage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController cardNumberController = TextEditingController();
  late String cardNo;
  late String cardExpiryYear;
  late String cardExpiryMonth;
  late String cardExpiryCVV;

  Future<void> payInvoice(BuildContext context) async {
    final userProvider = Provider.of<AuthProvider>(context, listen: false);
    final subscriptionProvider =
        Provider.of<SubscriptionProvider>(context, listen: false);
    String? token = await userProvider.getToken();
    final Uri url =
        Uri.parse("${AppConstants.API_URL}${AppConstants.PAY_INVOICE}");
    final response = await http.post(
      url,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode({
        'invoice_id': widget.id,
        'payment_method': 'stripe',
        'card_no': cardNo,
        'cc_expiry_month': cardExpiryMonth,
        'cc_expiry_year': cardExpiryYear,
        'cc_cvv_no': cardExpiryCVV
      }),
    );

    if (response.statusCode == 200) {
      // ignore: use_build_context_synchronously
      await subscriptionProvider.loadInvoices(context);
      // ignore: use_build_context_synchronously
      await subscriptionProvider.loadPackages(context);
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
      return;
    } else {
      throw Exception('Couldn\'t pay for the invoice.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
              decoration: const BoxDecoration(color: Colors.black),
            ),
            const SizedBox(width: 10.0),
            Text(
              "PARTNER",
              style:
                  GoogleFonts.dmSans(textStyle: FontThemeData.partnerHeading),
            ),
          ],
        ),
        toolbarHeight: 80.0,
        elevation: 0,
        backgroundColor: const Color.fromRGBO(248, 248, 248, 1.0),
        shadowColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Form(
          key: _formKey,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            color: const Color.fromRGBO(248, 248, 248, 1.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                const SizedBox(height: 15.0),
                SizedBox(
                  width: size.width - 40.0,
                  child: Text(
                    "Pay Your Invoice",
                    style: GoogleFonts.dmSans(
                        textStyle: FontThemeData.sectionTitles),
                  ),
                ),
                const SizedBox(height: 10.0),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Image(
                    width: 100.0,
                    image: AssetImage('assets/images/powered-by-stripe.png'),
                  ),
                ),
                const SizedBox(height: 10.0),
                Text(
                  "Card Details",
                  style: GoogleFonts.dmSans(fontSize: 13.0),
                ),
                const SizedBox(height: 5.0),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 20.0,
                  ),
                  child: TextFormField(
                    validator: (value) =>
                        value!.isEmpty ? 'Enter your Card Number' : null,
                    onSaved: (value) => cardNo = value!,
                    controller: cardNumberController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(19),
                      CardNumberInputFormatter(),
                    ],
                    style: const TextStyle(
                      color: Colors.black,
                      decorationColor: Colors.black,
                    ),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 5.0),
                      hintText: 'Card Number',
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      prefixIcon:
                          const Icon(Icons.credit_card, color: Colors.black),
                      hintStyle: const TextStyle(
                          color: Colors.black45, fontSize: 15.0),
                      enabledBorder: InputsThemeData.inputBorder,
                      focusedBorder: InputsThemeData.inputBorderSelected,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 20.0,
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 100.0,
                        child: TextFormField(
                          validator: (value) => value!.isEmpty
                              ? 'Enter your Card Expiry Month'
                              : null,
                          onSaved: (value) => cardExpiryMonth = value!,
                          keyboardType: TextInputType.number,
                          style: const TextStyle(
                            color: Colors.black,
                            decorationColor: Colors.black,
                          ),
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 5.0),
                            hintText: '01',
                            filled: true,
                            fillColor: Colors.grey.shade200,
                            prefixIcon: const Icon(Icons.calendar_month,
                                color: Colors.black),
                            hintStyle: const TextStyle(
                                color: Colors.black45, fontSize: 15.0),
                            enabledBorder: InputsThemeData.inputBorder,
                            focusedBorder: InputsThemeData.inputBorderSelected,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      SizedBox(
                        width: 100.0,
                        child: TextFormField(
                          validator: (value) => value!.isEmpty
                              ? 'Enter your Card Expiry Year'
                              : null,
                          onSaved: (value) => cardExpiryYear = value!,
                          keyboardType: TextInputType.number,
                          style: const TextStyle(
                            color: Colors.black,
                            decorationColor: Colors.black,
                          ),
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 5.0),
                            hintText: '23',
                            filled: true,
                            fillColor: Colors.grey.shade200,
                            prefixIcon: const Icon(Icons.calendar_month,
                                color: Colors.black),
                            hintStyle: const TextStyle(
                                color: Colors.black45, fontSize: 15.0),
                            enabledBorder: InputsThemeData.inputBorder,
                            focusedBorder: InputsThemeData.inputBorderSelected,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 150.0,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      bottom: 20.0,
                    ),
                    child: TextFormField(
                      validator: (value) =>
                          value!.isEmpty ? 'Enter your CVV No' : null,
                      onSaved: (value) => cardExpiryCVV = value!,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(
                        color: Colors.black,
                        decorationColor: Colors.black,
                      ),
                      maxLength: 3,
                      maxLengthEnforcement: MaxLengthEnforcement.enforced,
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 5.0),
                        hintText: 'CVV',
                        filled: true,
                        fillColor: Colors.grey.shade200,
                        prefixIcon: const Icon(Icons.security_outlined,
                            color: Colors.black),
                        hintStyle: const TextStyle(
                            color: Colors.black45, fontSize: 15.0),
                        enabledBorder: InputsThemeData.inputBorder,
                        focusedBorder: InputsThemeData.inputBorderSelected,
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      payInvoice(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30.0,
                      vertical: 10.0,
                    ),
                    foregroundColor: Colors.teal.shade400,
                    backgroundColor: Colors.teal.shade400,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        10.0,
                      ),
                    ),
                  ),
                  child: Text(
                    "PAY INVOICE",
                    softWrap: true,
                    style: GoogleFonts.dmSans(
                      textStyle: FontThemeData.btnBlackText,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
