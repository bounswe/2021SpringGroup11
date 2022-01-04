class User {
  String? username;
  String? email;
  String? firstname;
  String? lastname;
  String? bio;
  int? finishedResourceCount;
  int? enrolls;
  int? followed_paths;
  int? finished_paths;
  int follower;
  int following;
  String? photo;
  bool? rememberMe;
  User({
    this.username, this.email, this.firstname, this.lastname, this.bio, this.finishedResourceCount, this.photo, this.rememberMe, this.finished_paths, this.followed_paths, this.enrolls, required this.follower, required this.following
  });

  static User? me;
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        username: json['username'] as String?,
        email: json['email'] as String?,
        firstname: json['firstname'] as String?,
        lastname: json['lastname'] as String?,
        bio: json['bio'] as String?,
        finishedResourceCount: json['finishedResourceCount'] as int?,
        photo: json['photo'] as String?,
        rememberMe: json['rememberMe'] as bool?,
        finished_paths: json['finished_paths'] as int?,
        followed_paths: json['followed_paths'] as int?,
        enrolls: json['enrolls'] as int?,
        follower: json['follower'] as int,
        following: json['following'] as int
    );
  }
}