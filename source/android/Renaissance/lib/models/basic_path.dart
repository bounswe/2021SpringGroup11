class BasicPath {
  final String? title;
  final String? id;
  final String? photo;
  final double? effort;
  final double? rating;
  const BasicPath({
    this.title, this.id, this.photo, this.effort, this.rating
});
  factory BasicPath.fromJSON(Map<String, dynamic> json) {
    return BasicPath(title: json['title'], id: json['path_id'], photo: json['photo'], effort: json['effort'], rating: json['rating']);
  }
}