class SearchResult {
  final String title;
  final String url;
  final String snippet;
  final String? sourceImageUrl;

  SearchResult({
    required this.title,
    required this.url,
    required this.snippet,
    this.sourceImageUrl,
  });

  factory SearchResult.fromJson(Map<String, dynamic> json) {
    return SearchResult(
      title: json['title'] ?? '',
      url: json['url'] ?? '',
      snippet: json['snippet'] ?? '',
      sourceImageUrl: json['sourceImageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'url': url,
      'snippet': snippet,
      if (sourceImageUrl != null) 'sourceImageUrl': sourceImageUrl,
    };
  }
}