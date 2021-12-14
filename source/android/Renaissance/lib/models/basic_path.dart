class BasicPath {
  final String? title;
  final String? id;
  final String? photo;
  final double? effort;
  final double? rating;
  const BasicPath({this.title, this.id, this.photo, this.effort, this.rating});
  factory BasicPath.fromJSON(Map<String, dynamic> json) {
    return BasicPath(
        title: json['title'],
        id: json['_id'],
        photo: json['photo'],
        effort: json['effort'] as double,
        rating: json['rating'] as double);
  }
}
