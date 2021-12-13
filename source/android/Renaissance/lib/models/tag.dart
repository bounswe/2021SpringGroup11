import 'dart:async';

class Tag {
  final String? name;
  final String? id;
  final String? description;
  final bool? isFav;

  const Tag({this.name, this.id, this.description, this.isFav});
  factory Tag.fromJSON(Map<String, dynamic> json) {
    return Tag(
        name: json['name'],
        id: json['id'].toString(),
        description: json['description'],
        isFav: json['isFav']);
  }
}
