class User {
  final String? username;
  final String? email;
  final String? firstname;
  final String? lastname;
  final String? bio;
  final bool? isAdmin;
  final bool? isBanned;
  final int? finishedResourceCount;
  final String? photo;
  final bool? rememberMe;
  const User({
    this.username, this.email, this.firstname, this.lastname, this.bio, this.isAdmin, this.isBanned, this.finishedResourceCount, this.photo, this.rememberMe
  });

  static User? me;
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        username: json['username'] as String?,
        email: json['email'] as String?,
        firstname: json['firstname'] as String?,
        lastname: json['lastname'] as String?,
        bio: json['bio'] as String?,
        isAdmin: json['isAdmin'] as bool?,
        isBanned: json['isBanned'] as bool?,
        finishedResourceCount: json['finishedResourceCount'] as int?,
        photo: json['photo'] as String?,
        rememberMe: json['rememberMe'] as bool?
    );
  }
}