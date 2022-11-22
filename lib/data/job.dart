import 'dart:convert';
import 'package:beamcoda_jobs_partners_flutter/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import './auth.dart';
import '../types/jobpostcompact.dart';

class JobProvider extends ChangeNotifier {
  final List<JobPostCompact> _jobs = <JobPostCompact>[];

  List<JobPostCompact> get jobs => _jobs;

  Future<void> loadJobs(BuildContext ctx) async {
    final userProvider = Provider.of<AuthProvider>(ctx, listen: false);
    String? token = await userProvider.getToken();
    final userId = userProvider.partner.id;
    final Uri url = Uri.parse(
        "${AppConstants.API_URL}${AppConstants.JOBS_INDEX}?partner_id=$userId");
    final response = await http.get(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      _jobs.clear();
      data["data"].forEach(
        (job) => {
          _jobs.add(
            JobPostCompact.fromJson(job),
          ),
        },
      );

      notifyListeners();
      return;
    } else {
      throw Exception('Problem loading jobs.');
    }
  }
}
