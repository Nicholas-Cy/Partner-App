import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../data/auth.dart';
import '../../../ui/settings/subscription/payInvoice.dart';
import '../../../data/subscription.dart';
import '../../../types/subscription.dart';
import '../../../ui/theme_data/fonts.dart';

class PackageItem extends StatelessWidget {
  final Subscription package;
  const PackageItem({required Key key, required this.package})
      : super(key: key);

  showCreateInvoiceDialog(BuildContext context) {
    final subscriptionProvider =
        Provider.of<SubscriptionProvider>(context, listen: false);
    Widget consentBtn = ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.teal.shade400,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2.0),
        ),
      ),
      child: Text("Yes, Subscribe", style: GoogleFonts.dmSans()),
      onPressed: () async {
        subscriptionProvider.createInvoice(context, package).then((value) => {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) =>
                      PayInvoicePage(key: UniqueKey(), id: package.id),
                ),
              ),
            });
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Center(
          child: Text("Would you like to subscribe to ${package.name}?")),
      titleTextStyle:
          GoogleFonts.dmSans(textStyle: FontThemeData.jobPostSecondHeadingBold),
      actions: [
        consentBtn,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<AuthProvider>(context);
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        if (userProvider.partner.packageId != package.id) {
          if (int.parse(package.price) > 0) {
            showCreateInvoiceDialog(context);
          }
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0, bottom: 20.0),
        child: Container(
          width: width - 40.0,
          padding: const EdgeInsets.symmetric(
            vertical: 20.0,
            horizontal: 20.0,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              width: 1.0,
              color: const Color.fromRGBO(209, 209, 209, 1.0),
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              (userProvider.partner.packageId == package.id)
                  ? Positioned(
                      top: -40.0,
                      right: -10.0,
                      child: Container(
                        width: 80.0,
                        height: 40.0,
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20.0)),
                          border: Border.all(color: Colors.teal.shade400),
                          color: Colors.teal.shade50,
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10.0,
                              horizontal: 5.0,
                            ),
                            child: Text(
                              "ACTIVE",
                              style: GoogleFonts.dmSans(
                                  color: Colors.teal.shade400),
                            ),
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    package.name,
                    style: GoogleFonts.dmSans(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    "Price",
                    style: GoogleFonts.dmSans(
                      fontWeight: FontWeight.w600,
                      fontSize: 14.0,
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  Text("${package.price} (${package.subscriptionType})",
                      style: GoogleFonts.dmSans()),
                  const SizedBox(height: 10.0),
                  Text(
                    "Features",
                    style: GoogleFonts.dmSans(
                      fontWeight: FontWeight.w600,
                      fontSize: 14.0,
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: package.features.length,
                    itemBuilder: (_, i) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 5.0),
                        child: Text('- ${package.features[i]}'),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
