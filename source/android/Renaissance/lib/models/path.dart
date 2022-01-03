import 'package:portakal/models/basic_path.dart';
import 'package:portakal/models/milestone_model.dart';
import 'package:portakal/models/topic_model.dart';
class Path {
  String id;
  String title;
  String description;
  List<Topic>? topics;
  String creator_username;
  String creator_email;
  double created_at;
  String? photo;
  List<Milestonee> milestones;
  double rating;
  double effort;
  bool? isEnrolled;
  bool? isFollowed;
  Path({
    required this.id, required this.title, required this.description, this.topics, required this.creator_username, required this.creator_email, required this.created_at, this.photo, required this.milestones, required this.rating, required this.effort, this.isEnrolled,this.isFollowed
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