class Milestonee {
  final String? id;
  final String? title;
  final String? body;
  final bool? isFinished;

  const Milestonee({this.id, this.title,this.body,this.isFinished});

  factory Milestonee.fromJson(Map<String, dynamic> json){
    return Milestonee(id: json['_id'], title: json['title'], body: json['body'], isFinished: json['isFinished']);
  }
}