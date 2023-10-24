class JobPostDetailed {
  JobPostDetailed(
      {required this.id,
      required this.title,
      required this.deadlineDate,
      required this.jobCategory,
      required this.isRemote,
      required this.jobLocation,
      required this.jobType,
      required this.desc,
      required this.payRangeExists,
      this.minPayRange = '',
      this.maxPayRange = '',
      required this.skills,
      required this.status});
  final int id;
  final String title;
  final String deadlineDate;
  final String jobCategory;
  final String jobType;
  final bool isRemote;
  final String jobLocation;
  final String desc;
  final bool payRangeExists;
  String minPayRange;
  String maxPayRange;
  final List<dynamic> skills;
  final String status;
  factory JobPostDetailed.fromJson(Map<String, dynamic> json) {
    return JobPostDetailed(
      id: json['id'],
      title: json['title'],
      deadlineDate: json['expiration'],
      jobCategory: json['category']['name'],
      isRemote: (json['remote_position'] == 1) ? true : false,
      jobLocation: (json['remote_position'] == 0)
          ? json['city'] + ', ' + json['country']
          : '',
      jobType: json['job_type']['name'],
      desc: json['desc'],
      payRangeExists: (json['no_pay_range'] == 1) ? true : false,
      minPayRange: '${json['min_salary_range']}',
      maxPayRange: '${json['max_salary_range']}',
      skills: json['skills'].map((item) => item['name']).toList(),
      status: json['status'],
    );
  }
}
