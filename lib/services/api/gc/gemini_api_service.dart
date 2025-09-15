import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http_parser/http_parser.dart';
import 'package:okataduke/core/models/service/product_candidate.dart';

class GeminiAnalyzeResponse {
  final List<ProductCandidate> candidates;
  final bool success;
  final String? error;

  GeminiAnalyzeResponse({
    required this.candidates,
    required this.success,
    this.error,
  });

  factory GeminiAnalyzeResponse.fromJson(Map<String, dynamic> json) {
    final candidates = <ProductCandidate>[];

    if (json['status'] == 'success' && json['result'] != null) {
      try {
        final result = json['result'] as String;
        final jsonMatch =
            RegExp(r'```json\n(.*?)\n```', dotAll: true).firstMatch(result);

        if (jsonMatch != null) {
          final jsonString = jsonMatch.group(1);
          final List<dynamic> candidatesJson = jsonDecode(jsonString!);

          for (final item in candidatesJson) {
            candidates.add(ProductCandidate.fromJson(item));
          }
        }
      } catch (e) {
        return GeminiAnalyzeResponse(
          candidates: [],
          success: false,
          error: 'Failed to parse response: $e',
        );
      }
    }

    return GeminiAnalyzeResponse(
      candidates: candidates,
      success: json['status'] == 'success',
      error: json['status'] != 'success' ? 'Analysis failed' : null,
    );
  }
}

class GeminiApiService {
  final String baseUrl;
  final http.Client _client;

  GeminiApiService({http.Client? client})
      : baseUrl = dotenv.env['GC_API_BASE_URL'] ?? '',
        _client = client ?? http.Client();

  Future<GeminiAnalyzeResponse> analyzeImage({
    required String imagePath,
    required String prompt,
  }) async {
    try {
      final uri = Uri.parse('$baseUrl/api/v1/gemini/analyze');
      final request = http.MultipartRequest('POST', uri);

      final file = File(imagePath);
      if (!await file.exists()) {
        return GeminiAnalyzeResponse(
          candidates: [],
          success: false,
          error: 'Image file not found: $imagePath',
        );
      }

      // Content-Typeを明示的に指定
      final bytes = await file.readAsBytes();
      final filename = imagePath.split('/').last;
      final multipartFile = http.MultipartFile.fromBytes(
        'file',
        bytes,
        filename: filename,
        contentType: MediaType('image', 'jpeg'),
      );

      request.files.add(multipartFile);
      request.fields['prompt'] = prompt;

      final streamedResponse = await _client.send(request);
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        return GeminiAnalyzeResponse.fromJson(responseData);
      } else {
        return GeminiAnalyzeResponse(
          candidates: [],
          success: false,
          error: 'HTTP ${response.statusCode}: ${response.body}',
        );
      }
    } catch (e) {
      return GeminiAnalyzeResponse(
        candidates: [],
        success: false,
        error: 'Request failed: $e',
      );
    }
  }

  void dispose() {
    _client.close();
  }
}
