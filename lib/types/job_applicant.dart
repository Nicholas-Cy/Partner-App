/// Job Applicant Data Type Definition
class JobApplicant {
  JobApplicant(
      {required this.id,
      required this.name,
      required this.img,
      required this.profession,
      required this.shortlisted,
      required this.read});
  final int id;
  late String name;
  late String img;
  late String profession;
  late bool shortlisted;
  late bool read;

  factory JobApplicant.fromJson(Map<String, dynamic> json) {
    return JobApplicant(
      id: json['id'],
      name: json['user']['full_name'],
      img: json['user']['profile_picture'],
      profession: json['user']['profession'],
      shortlisted: (json['shortlisted'] == 1) ? true : false,
      read: (json['read'] == 1) ? true : false,
    );
  }
}
