class UserVM {
  late String key;
  final String firstName;
  final String lastName;
  final String email;
  final String birthday;
  final String password;
  final bool admin;

  UserVM({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.birthday,
    required this.password,
    required this.admin,
  });

  set id(String uniqueUserId) {
    key = uniqueUserId;
  }
}
