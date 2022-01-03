import 'package:portakal/models/basic_path.dart';
import 'package:portakal/models/topic_model.dart';

class HomePageResponse {
  final List<BasicPath> paths;
  final List<Topic> topics;
  const HomePageResponse({
    required this.paths, required this.topics
});
  
  factory HomePageResponse.fromJSON(Map<String, dynamic> json) {
    return HomePageResponse(paths: (json['paths'] as List).map((json) => BasicPath.fromJSON(json)).toList(),
        topics: (json['topics'] as List).map((json) => Topic.fromJson(json)).toList());
  }
}