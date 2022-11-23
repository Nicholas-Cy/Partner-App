// Job Post List Data Type
class JobPostCompact {
  const JobPostCompact({
    required this.id,
    required this.title,
    required this.location,
    required this.timeAgo,
    required this.applicantsCount,
  });
  final int id;
  final String title;
  final String location;
  final String timeAgo;
  final int applicantsCount;
  factory JobPostCompact.fromJson(Map<String, dynamic> json) {
    return JobPostCompact(
      id: json['id'],
      title: json['job_title'],
      location: (json['is_remote'] == 1)
          ? 'Remote'
          : json['city'] + ', ' + json['country'],
      timeAgo: json['created_at'],
      applicantsCount: json['applicants_count'],
    );
  }
}
