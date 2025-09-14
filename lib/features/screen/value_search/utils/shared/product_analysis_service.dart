import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:okataduke/services/api/gc/gemini_api_service.dart';
import 'package:okataduke/features/screen/value_search/utils/shared/vision_search_service.dart';

class ProductAnalysisResult {
  final String productName;
  final int confidence;
  final bool success;
  final String? error;

  ProductAnalysisResult({
    required this.productName,
    required this.confidence,
    required this.success,
    this.error,
  });
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
          productName: response.candidates[0].name,
          confidence: (response.candidates[0].confidence * 100).round(),
          success: true,
        );
      } else {
        return ProductAnalysisResult(
          productName: '',
          confidence: 0,
          success: false,
          error: 'Gemini API Error: ${response.error}',
        );
      }
    } catch (e) {
      return ProductAnalysisResult(
        productName: '',
        confidence: 0,
        success: false,
        error: 'Analysis failed: $e',
      );
    }
  }
}