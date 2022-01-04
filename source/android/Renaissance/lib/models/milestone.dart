class Milestone {
  final String? title;
  final String? body;

  const Milestone({
    this.title, this.body
});
  factory Milestone.fromJson(Map<String, dynamic> json) {
    return Milestone(title: json['title'], body: json['body']);
  }
}