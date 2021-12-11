class Path {
  final String? username;
  final String? email;
  final String? firstname;
  final String? lastname;
  final String? bio;
  final bool? isAdmin;
  final bool? isBanned;
  const Path({
    this.username, this.email, this.firstname, this.lastname, this.bio, this.isAdmin, this.isBanned
  });

  static Path? me;
  factory Path.fromJson(Map<String, dynamic> json) {
    return Path(
        username: json['username'] as String?,
        email: json['email'] as String?,
        firstname: json['firstname'] as String?,
        lastname: json['lastname'] as String?,
        bio: json['bio'] as String?,
        isAdmin: json['isAdmin'] as bool?,
        isBanned: json['isBanned'] as bool?
    );
  }
}