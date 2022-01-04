class Activity {
  final String? summary;
  final String? time;

  const Activity({this.summary, this.time});
  factory Activity.fromJSON(Map<String, dynamic> json) {
    return Activity(
        summary: json['summary'],
        time: json['published']);

  }
}
