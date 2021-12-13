class GetFollowResponse {
  final List<String>? followers;
  final List<String>? followed;

  const GetFollowResponse({
    this.followed, this.followers});

  factory GetFollowResponse.fromJSON(Map<String, dynamic> json){
    return GetFollowResponse(followed: json['followed'], followers: json['followers']);
  }
}