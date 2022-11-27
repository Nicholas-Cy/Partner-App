import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../types/invoice.dart';
import 'pay_invoice.dart';

class InvoiceItem extends StatelessWidget {
  final Invoice invoice;
  const InvoiceItem({required Key key, required this.invoice})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        if (invoice.isPaid == false) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) =>
                  PayInvoicePage(key: UniqueKey(), id: invoice.id),
            ),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        invoice.packageName,
                        style: GoogleFonts.dmSans(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                      (invoice.isPaid)
                          ? Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Container(
                                width: 100.0,
                                height: 40.0,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20.0)),
                                  border:
                                      Border.all(color: Colors.teal.shade400),
                                  color: Colors.teal.shade50,
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 10.0,
                                      horizontal: 5.0,
                                    ),
                                    child: Text(
                                      "PAID",
                                      style: GoogleFonts.dmSans(
                                          color: Colors.teal.shade400,
                                          fontSize: 13.0),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox(),
                    ],
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
                  Text(invoice.amount, style: GoogleFonts.dmSans()),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
