import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import './auth.dart';
import '../types/invoice.dart';
import '../types/subscription.dart';
import '../utils/constants.dart';

class SubscriptionProvider extends ChangeNotifier {
  final List<Subscription> _packages = <Subscription>[];
  final List<Invoice> _invoices = <Invoice>[];

  List<Subscription> get packages => _packages;
  List<Invoice> get invoices => _invoices;

  Future<void> loadPackages(BuildContext context) async {
    final userProvider = Provider.of<AuthProvider>(context, listen: false);
    String? token = await userProvider.getToken();
    final Uri url =
        Uri.parse("${AppConstants.API_URL}${AppConstants.PACKAGES_INDEX}");
    final response = await http.get(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      _packages.clear();
      data["data"].forEach(
        (package) => {
          _packages.add(
            Subscription.fromJson(package),
          ),
        },
      );

      notifyListeners();
      return;
    } else {
      throw Exception('Problem loading packages.');
    }
  }

  Future<void> loadInvoices(BuildContext context) async {
    final userProvider = Provider.of<AuthProvider>(context, listen: false);
    String? token = await userProvider.getToken();
    String userId = userProvider.partner.id.toString();
    final Uri url = Uri.parse(
        "${AppConstants.API_URL}${AppConstants.INVOICES_INDEX}/$userId");
    final response = await http.get(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      _invoices.clear();
      data["data"].forEach(
        (invoice) => {
          _invoices.add(
            Invoice.fromJson(invoice),
          ),
        },
      );

      notifyListeners();
      return;
    } else {
      throw Exception('Problem loading invoices.');
    }
  }

  Future<int> createInvoice(BuildContext context, Subscription package) async {
    final userProvider = Provider.of<AuthProvider>(context, listen: false);
    String? token = await userProvider.getToken();
    final userId = userProvider.partner.id;
    final Uri url =
        Uri.parse("${AppConstants.API_URL}${AppConstants.CREATE_INVOICE}");
    final String currTime =
        DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.now()).toString();
    final String dueDate = DateFormat('yyyy-MM-dd hh:mm:ss')
        .format(DateTime.now().add(const Duration(days: 7)))
        .toString();
    final response = await http.post(
      url,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode({
        'partner_id': userId,
        'package_id': package.id,
        'amount': double.parse(package.price),
        'invoiced_date': currTime,
        'due_date': dueDate,
        'is_paid': 0,
      }),
    );

    if (response.statusCode == 201) {
      Map<String, dynamic> responseJson = json.decode(response.body);
      int invoiceId = responseJson["data"]["id"];

      return invoiceId;
    } else {
      throw Exception('Couldn\'t create an invoice.');
    }
  }
}
