import 'package:portakal/models/basic_path.dart';
import 'package:portakal/models/tag.dart';
import 'package:portakal/models/topic_model.dart';

class HomePageResponse {
  final List<BasicPath> paths;
  final List<Tag> tags;
  const HomePageResponse({
    required this.paths, required this.tags
});
  
  factory HomePageResponse.fromJSON(Map<String, dynamic> json) {
    return HomePageResponse(paths: (json['paths'] as List).map((json) => BasicPath.fromJSON(json)).toList(),
        tags: (json['topics'] as List).map((json) => Tag.fromSpecialJSON(json)).toList());
  }
}