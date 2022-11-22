/// Register Partner Data Type Definition
class RegisterPartner {
  RegisterPartner({
    required this.id,
    required this.email,
    required this.password,
    required this.passwordConfirmation,
    required this.companyName,
    required this.displayName,
    required this.employeeCount,
    required this.bio,
  });
  late int id;
  late String email;
  late String password;
  late String passwordConfirmation;
  late String companyName;
  late String displayName;
  late String employeeCount;
  late String bio;
}
