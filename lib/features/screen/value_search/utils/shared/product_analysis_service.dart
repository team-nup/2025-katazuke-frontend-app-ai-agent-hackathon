import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:okataduke/services/api/gc/gemini_api_service.dart';
import 'package:okataduke/features/screen/value_search/utils/shared/vision_search_service.dart';
import 'package:okataduke/core/models/service/product_candidate.dart';

class ProductAnalysisResult {
  final List<ProductCandidate> candidates;
  final bool success;
  final String? error;

  ProductAnalysisResult({
    required this.candidates,
    required this.success,
    this.error,
  });

  String get productName => candidates.isNotEmpty ? candidates.first.name : '';
  int get confidence => candidates.isNotEmpty ? (candidates.first.confidence * 100).round() : 0;
}

class ProductAnalysisService {
  static Future<ProductAnalysisResult> analyzeProduct({
    required String imagePath,
    String? userHint,
  }) async {
    try {
      final visionSearchResult = await VisionSearchService.analyzeImageAndSearch(
        imagePath: imagePath,
      );

      final urlHintsJson = visionSearchResult.urlHints.map((hint) => hint.toJson()).toList();
      final urlHintsString = jsonEncode(urlHintsJson);

      final basePrompt = dotenv.env['GEMINI_ANALYSIS_PROMPT'] ?? 'この画像について説明してください';
      final prompt = '$basePrompt\n{userHint: "${userHint ?? ""}", urlHint: $urlHintsString}';

      final geminiService = GeminiApiService();
      final response = await geminiService.analyzeImage(
        imagePath: imagePath,
        prompt: prompt,
      );

      geminiService.dispose();

      if (response.success && response.candidates.isNotEmpty) {
        return ProductAnalysisResult(
          candidates: response.candidates,
          success: true,
        );
      } else {
        return ProductAnalysisResult(
          candidates: [],
          success: false,
          error: 'Gemini API Error: ${response.error}',
        );
      }
    } catch (e) {
      return ProductAnalysisResult(
        candidates: [],
        success: false,
        error: 'Analysis failed: $e',
      );
    }
  }
}