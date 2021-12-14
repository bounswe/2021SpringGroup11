class Topic {
  final int? ID;
  final String? name;
  final String? description;

  const Topic({this.ID, this.name,this.description});

  factory Topic.fromJson(Map<String, dynamic> json){
    return Topic(ID: json['ID'], name: json['name'], description: json['description']);
  }
}