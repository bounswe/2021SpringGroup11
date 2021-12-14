import 'package:portakal/models/basic_path.dart';
import 'package:portakal/models/milestone_model.dart';
import 'package:portakal/models/topic_model.dart';
class Path {
  final String? id;
  final String? title;
  final String? description;
  final List<Topic>? topics;
  final String? creator_username;
  final String? creator_email;
  final double? created_at;
  final String? photo;
  final List<Milestonee>? milestones;
  final double? rating;
  final double? effort;
  final bool? isEnrolled;
  final bool? isFollowed;
  const Path({
    this.id, this.title, this.description, this.topics, this.creator_username, this.creator_email, this.created_at, this.photo, this.milestones, this.rating, this.effort, this.isEnrolled,this.isFollowed
});

  factory Path.fromJson(Map<String, dynamic> json) {
    return Path(id: json['_id'], title: json['title'], description: json['description'], topics: (json['topics']).map((muz) => Topic.fromJson(muz)).toList(), creator_username: json['creator_username'], created_at: json['created_at'],
      photo: json['photo'], milestones: (json['milestones'] as List<Map<String, dynamic>>).map((json) => Milestonee.fromJson(json)).toList(), rating: json['rating'], effort: json['effort'],
        creator_email: json['creator_email']);
  }

  BasicPath basic() {
    return BasicPath(title: this.title, id: this.id, photo: this.photo, effort: this.effort, rating: this.rating);
  }
}