class SearchResult {
  final String usernames;
  SearchResult({required this.usernames});

  factory SearchResult.fromJson(Map<String, dynamic> json) {
    return SearchResult(
      usernames: json['username'],
    );
  }
}
