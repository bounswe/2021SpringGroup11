class BasicPath {
  String title;
  String id;
  String? photo;
  double effort;
  double rating;
  bool? isFollowed;
  BasicPath({required this.title, required this.id, this.photo, required this.effort, required this.rating, this.isFollowed});
  factory BasicPath.fromJSON(Map<String, dynamic> json) {
    return BasicPath(
        title: json['title'],
        id: json['_id'],
        photo: json['photo'],
        isFollowed: json['isFollowed'],
        effort: json['effort'] as double,
        rating: json['rating'] as double);
  }
}
