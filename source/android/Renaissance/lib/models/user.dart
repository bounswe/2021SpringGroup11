class User {
  final String? username;
  final String? email;
  final String? firstname;
  final String? lastname;
  final String? profilePictureUrl;
  final String? bio;
  final bool? isAdmin;

  const User({
    this.username, this.email, this.firstname, this.lastname, this.profilePictureUrl, this.bio, this.isAdmin
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        username: json['username'] as String?,
        email: json['email'] as String?,
        firstname: json['firstname'] as String?,
        lastname: json['lastname'] as String?,
        profilePictureUrl: json['profilePictureUrl'] as String?,
        bio: json['bio'] as String?,
        isAdmin: json['isAdmin'] as bool?
    );
  }
}