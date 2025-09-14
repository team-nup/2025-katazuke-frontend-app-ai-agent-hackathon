import 'package:okataduke/services/api/gc/vision_api_service.dart';
import 'package:okataduke/services/api/google/custom_search_service.dart';
import 'package:okataduke/core/models/service/url_hint.dart';
import 'package:okataduke/core/models/service/search_result.dart';

class VisionSearchResult {
  final List<UrlHint> urlHints;
  final bool success;
  final String? error;

  VisionSearchResult({
    required this.urlHints,
    required this.success,
    this.error,
  });
}

class VisionSearchService {
  static Future<VisionSearchResult> analyzeImageAndSearch({
    required String imagePath,
  }) async {
    try {
      final visionService = VisionApiService();
      final visionResponse =
          await visionService.detectWeb(imagePath: imagePath);

      if (!visionResponse.success || visionResponse.webDetection == null) {
        visionService.dispose();
        return VisionSearchResult(
          urlHints: [],
          success: false,
          error: 'Vision API failed: ${visionResponse.error}',
        );
      }

      final similarImages = visionResponse.webDetection!.visuallySimilarImages
          .take(3)
          .map((image) => image.url)
          .toList();

      if (similarImages.isEmpty) {
        visionService.dispose();
        return VisionSearchResult(
          urlHints: [],
          success: true,
        );
      }

      final searchService = CustomSearchService();
      final allSearchResults = <SearchResult>[];

      for (final imageUrl in similarImages) {
        try {
          final searchResults =
              await searchService.getPageTitlesFromSimilarImages([imageUrl]);

          final limitedResults = searchResults
              .take(2)
              .map((result) => SearchResult(
                    title: result.title,
                    url: result.url,
                    snippet: result.snippet,
                    sourceImageUrl: result.sourceImageUrl,
                  ))
              .toList();

          allSearchResults.addAll(limitedResults);
        } catch (e) {
          continue;
        }
      }

      final urlHints = allSearchResults
          .map((result) => UrlHint(
                title: result.title,
                snippet: result.snippet,
                url: result.url,
              ))
          .toList();

      visionService.dispose();
      searchService.dispose();

      return VisionSearchResult(
        urlHints: urlHints,
        success: true,
      );
    } catch (e) {
      return VisionSearchResult(
        urlHints: [],
        success: false,
        error: 'Analysis failed: $e',
      );
    }
  }
}
