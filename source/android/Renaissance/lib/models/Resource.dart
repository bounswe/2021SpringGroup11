class Resource {
  final String? username;
  final int? taskId;
  final String? description;
  final String? link;
  const Resource({
   this.username, this.taskId, this.description, this.link
});

  factory Resource.fromJSON(Map<String, dynamic> json) {
    return Resource(
        username: json['username'],
        taskId: json['order'],
        description: json['description'],
        link: json['link']);
  }
}