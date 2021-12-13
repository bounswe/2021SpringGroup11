class Milestone {
  final String? id;
  final String? title;
  final String? body;
  final bool? isFinished;

  const Milestone({this.id, this.title,this.body,this.isFinished});

  factory Milestone.fromJSON(Map<String, dynamic> json){
    return Milestone(id: json['_id'], title: json['title'], body: json['body'], isFinished: json['isFinished']);
  }
}