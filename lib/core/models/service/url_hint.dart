class UrlHint {
  final String title;
  final String snippet;
  final String url;

  UrlHint({
    required this.title,
    required this.snippet,
    required this.url,
  });

  factory UrlHint.fromJson(Map<String, dynamic> json) {
    return UrlHint(
      title: json['title'] ?? '',
      snippet: json['snippet'] ?? '',
      url: json['url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'snippet': snippet,
      'url': url,
    };
  }
}