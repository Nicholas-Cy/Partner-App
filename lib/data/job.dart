import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import './auth.dart';
import '../types/jobpostcompact.dart';
import '../types/category.dart';
import '../types/job_types.dart';
import '../types/new_post.dart';
import '../types/post_duration.dart';
import '../types/skill.dart';
import '../utils/constants.dart';

class JobProvider extends ChangeNotifier {
  final List<JobPostCompact> _jobs = <JobPostCompact>[];
  final List<Category> _categories = <Category>[];
  final List<JobType> _jobTypes = <JobType>[];
  final List<PostDuration> _postDurations = <PostDuration>[];
  final List<Skill> _skills = <Skill>[];
  final List<Skill> _jobSkills = <Skill>[];
  bool _newPostInit = false;
  late NewPost _newPost;

  List<JobPostCompact> get jobs => _jobs;
  List<Category> get categories => _categories;
  List<JobType> get jobTypes => _jobTypes;
  List<Skill> get skills => _skills;
  List<Skill> get jobSkills => _jobSkills;
  List<PostDuration> get postDurations => _postDurations;
  bool get newPostInit => _newPostInit;
  NewPost get newPost => _newPost;

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

  Future<void> loadCategories(BuildContext ctx) async {
    String? token =
        await Provider.of<AuthProvider>(ctx, listen: false).getToken();
    final Uri url =
        Uri.parse("${AppConstants.API_URL}${AppConstants.CATEGORIES_INDEX}");
    final response = await http.get(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      _categories.clear();
      data["data"].forEach(
        (category) => {
          _categories.add(
            Category.fromJson(category),
          ),
        },
      );

      notifyListeners();
      return;
    } else {
      throw Exception('Problem loading categories.');
    }
  }

  Future<void> loadJobTypes(BuildContext ctx) async {
    String? token =
        await Provider.of<AuthProvider>(ctx, listen: false).getToken();
    final Uri url =
        Uri.parse("${AppConstants.API_URL}${AppConstants.JOBTYPES_INDEX}");
    final response = await http.get(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      _jobTypes.clear();
      data["data"].forEach(
        (jobtype) => {
          _jobTypes.add(
            JobType.fromJson(jobtype),
          ),
        },
      );

      notifyListeners();
      return;
    } else {
      throw Exception('Problem loading job types.');
    }
  }

  Future<void> loadPostDurations(BuildContext ctx) async {
    final userProvider = Provider.of<AuthProvider>(ctx, listen: false);
    String? token = await userProvider.getToken();
    final partnerId = userProvider.partner.id;
    final Uri url = Uri.parse(
        "${AppConstants.API_URL}${AppConstants.POSTDURATIONS_INDEX}/$partnerId");
    final response = await http.get(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      _postDurations.clear();
      data["data"].forEach(
        (postduration) => {
          _postDurations.add(
            PostDuration.fromJson(postduration),
          ),
        },
      );

      notifyListeners();
      return;
    } else {
      throw Exception('Problem loading post duration.');
    }
  }

  Future<void> loadSkills(BuildContext ctx) async {
    final userProvider = Provider.of<AuthProvider>(ctx, listen: false);
    String? token = await userProvider.getToken();
    final Uri skillsUrl =
        Uri.parse("${AppConstants.API_URL}${AppConstants.SKILLS_INDEX}");
    final skillsResponse = await http.get(skillsUrl, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });
    if (skillsResponse.statusCode == 200) {
      Map<String, dynamic> data = json.decode(skillsResponse.body);
      _skills.clear();
      data["data"].forEach(
        (skill) => {
          _skills.add(
            Skill.fromJson(skill),
          ),
        },
      );
    } else {
      throw Exception('Problem loading skills list from database.');
    }

    notifyListeners();
    return;
  }

  addSkillToList(Skill skill) async {
    _jobSkills.add(skill);
    notifyListeners();
  }

  removeSkillFromList(Skill skill) async {
    _jobSkills.remove(skill);
    notifyListeners();
  }

  Future<void> initNewPost(BuildContext ctx) async {
    final userProvider = Provider.of<AuthProvider>(ctx, listen: false);
    final partnerId = userProvider.partner.id;
    final NewPost initNewPost = NewPost(
        partnerId: partnerId,
        title: '',
        isRemote: false,
        city: '',
        country: '',
        category: categories[0].id,
        noPayRange: false,
        minSalary: 0,
        maxSalary: 0,
        jobType: jobTypes[0].id,
        desc: '',
        jobActiveDuration: postDurations[0].id,
        isPublished: false,
        status: 'active');

    _newPostInit = true;
    _newPost = initNewPost;
    notifyListeners();
    return;
  }
}
