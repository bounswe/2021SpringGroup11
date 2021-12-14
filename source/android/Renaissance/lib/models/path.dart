import 'package:portakal/models/basic_path.dart';
import 'package:portakal/models/milestone.dart';

class Path {
  final String? id;
  final String? title;
  final String? description;
  final List<int>? topics;
  final String? creator_username;
  final String? creator_email;
  final double? created_at;
  final String? photo;
  final List<Milestone>? milestones;
  final double? rating;
  final double? effort;
  const Path({
    this.id, this.title, this.description, this.topics, this.creator_username, this.creator_email, this.created_at, this.photo, this.milestones, this.rating, this.effort
});

  factory Path.fromJson(Map<String, dynamic> json) {
    return Path(id: json['_id'], title: json['title'], description: json['description'], topics: json['topics'], creator_username: json['creator_username'], created_at: json['created_at'],
      photo: json['photo'], milestones: (json['milestones'] as List<Map<String, dynamic>>).map((json) => Milestone.fromJson(json)).toList(), rating: json['rating'], effort: json['effort'],
        creator_email: json['creator_email']);
  }

  BasicPath basic() {
    return BasicPath(title: this.title, id: this.id, photo: this.photo, effort: this.effort, rating: this.rating);
  }
}