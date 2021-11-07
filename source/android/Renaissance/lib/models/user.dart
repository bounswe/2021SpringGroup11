class User {
  late String username;
  late String email;
  late String firstName;
  late String lastName;
  late String profilePictureUrl;

  User({ required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.profilePictureUrl
  });

  User.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    email = json['email'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    profilePictureUrl = json['profilePictureUrl'];
  }
}