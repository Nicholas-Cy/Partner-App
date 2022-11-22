/// Partner Data Type Definition
class Partner {
  Partner(
      {required this.id,
      required this.name,
      required this.displayName,
      required this.email,
      required this.img,
      required this.bio,
      required this.packageId,
      required this.memberSince});
  final int id;
  late String name;
  late String displayName;
  late String email;
  late String img;
  late String bio;
  late int packageId;
  late String memberSince;

  factory Partner.fromJson(Map<String, dynamic> json) {
    return Partner(
        id: json['id'],
        name: json['name'],
        displayName: json['display_name'],
        email: json['email'],
        img: json['profile_picture'],
        bio: json['bio'],
        packageId: json['package'][0]['id'],
        memberSince: json['member_since']);
  }
}
