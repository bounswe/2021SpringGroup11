class BasicUser {
  final String? username;
  final String? photo;

  const BasicUser({this.username, this.photo});
  factory BasicUser.fromJSON(Map<String, dynamic> json) {
    return BasicUser(
      username: json['username'],
      photo: json['photo'],
    );
  }
}
