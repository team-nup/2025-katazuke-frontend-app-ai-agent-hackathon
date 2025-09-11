import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

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
}

class CustomSearchService {
  final String apiKey;
  final String searchEngineId;
  final http.Client _client;

  CustomSearchService({
    http.Client? client,
  })  : apiKey = dotenv.env['GOOGLE_CUSTOM_SEARCH_API_KEY'] ?? '',
        searchEngineId = dotenv.env['GOOGLE_CUSTOM_SEARCH_ENGINE_ID'] ?? '',
        _client = client ?? http.Client();

  Future<List<SearchResult>> getPageTitlesFromSimilarImages(
      List<String> visuallySimilarImageUrls) async {
    final results = <SearchResult>[];

    for (final imageUrl in visuallySimilarImageUrls) {
      final imageResults = await _searchPageByImageUrl(imageUrl);
      results.addAll(imageResults);

      // リクエスト間隔を空ける
      await Future.delayed(const Duration(milliseconds: 200));
    }
    print(results);
    return results;
  }

  Future<List<SearchResult>> _searchPageByImageUrl(String imageUrl) async {
    try {
      // 逆画像検索を実行
      final imageSearchUrl =
          'https://www.googleapis.com/customsearch/v1?key=$apiKey&cx=$searchEngineId&searchType=image&q=${Uri.encodeQueryComponent(imageUrl)}';

      final response = await _client.get(Uri.parse(imageSearchUrl));
      final data = jsonDecode(response.body);

      if (data.containsKey('error')) {
        return [];
      }

      if (data.containsKey('items') && (data['items'] as List).isNotEmpty) {
        final items = data['items'] as List;
        final results = <SearchResult>[];

        for (final item in items) {
          results.add(SearchResult(
            title: item['title'] ?? '',
            url: item['image']?['contextLink'] ?? item['link'] ?? '',
            snippet: item['snippet'] ?? '',
            sourceImageUrl: imageUrl,
          ));
        }

        return results;
      }

      return [];
    } catch (error) {
      return [];
    }
  }

  void dispose() {
    _client.close();
  }
}
