// New Post Data Type Definition
class NewPost {
  NewPost({
    required this.partnerId,
    required this.title,
    required this.isRemote,
    required this.city,
    required this.country,
    required this.category,
    required this.noPayRange,
    required this.minSalary,
    required this.maxSalary,
    required this.jobType,
    required this.desc,
    required this.jobActiveDuration,
    required this.isPublished,
    required this.status,
  });
  late int partnerId;
  late String title;
  late bool isRemote;
  late String city;
  late String country;
  late int category;
  late bool noPayRange;
  late int minSalary;
  late int maxSalary;
  late int jobType;
  late String desc;
  late int jobActiveDuration;
  late bool isPublished;
  late String status;
}
