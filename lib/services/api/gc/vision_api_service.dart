import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class WebEntity {
  final String? entityId;
  final double? score;
  final String? description;

  WebEntity({
    this.entityId,
    this.score,
    this.description,
  });

  factory WebEntity.fromJson(Map<String, dynamic> json) {
    return WebEntity(
      entityId: json['entityId'],
      score: json['score']?.toDouble(),
      description: json['description'],
    );
  }
}

class VisuallySimilarImage {
  final String url;

  VisuallySimilarImage({required this.url});

  factory VisuallySimilarImage.fromJson(Map<String, dynamic> json) {
    return VisuallySimilarImage(url: json['url'] ?? '');
  }
}

class BestGuessLabel {
  final String label;
  final String? languageCode;

  BestGuessLabel({
    required this.label,
    this.languageCode,
  });

  factory BestGuessLabel.fromJson(Map<String, dynamic> json) {
    return BestGuessLabel(
      label: json['label'] ?? '',
      languageCode: json['languageCode'],
    );
  }
}

class WebDetection {
  final List<WebEntity> webEntities;
  final List<VisuallySimilarImage> visuallySimilarImages;
  final List<BestGuessLabel> bestGuessLabels;

  WebDetection({
    required this.webEntities,
    required this.visuallySimilarImages,
    required this.bestGuessLabels,
  });

  factory WebDetection.fromJson(Map<String, dynamic> json) {
    final webEntities = <WebEntity>[];
    final visuallySimilarImages = <VisuallySimilarImage>[];
    final bestGuessLabels = <BestGuessLabel>[];

    if (json['webEntities'] != null) {
      for (final item in json['webEntities']) {
        webEntities.add(WebEntity.fromJson(item));
      }
    }

    if (json['visuallySimilarImages'] != null) {
      for (final item in json['visuallySimilarImages']) {
        visuallySimilarImages.add(VisuallySimilarImage.fromJson(item));
      }
    }

    if (json['bestGuessLabels'] != null) {
      for (final item in json['bestGuessLabels']) {
        bestGuessLabels.add(BestGuessLabel.fromJson(item));
      }
    }

    return WebDetection(
      webEntities: webEntities,
      visuallySimilarImages: visuallySimilarImages,
      bestGuessLabels: bestGuessLabels,
    );
  }
}

class VisionApiResponse {
  final WebDetection? webDetection;
  final bool success;
  final String? error;

  VisionApiResponse({
    this.webDetection,
    required this.success,
    this.error,
  });

  factory VisionApiResponse.fromJson(Map<String, dynamic> json) {
    try {
      final responses = json['responses'] as List;
      if (responses.isNotEmpty) {
        final firstResponse = responses[0];

        if (firstResponse['error'] != null) {
          return VisionApiResponse(
            success: false,
            error: firstResponse['error'].toString(),
          );
        }

        final webDetectionData = firstResponse['webDetection'];
        if (webDetectionData != null) {
          return VisionApiResponse(
            webDetection: WebDetection.fromJson(webDetectionData),
            success: true,
          );
        }
      }

      return VisionApiResponse(
        success: false,
        error: 'No valid response received',
      );
    } catch (e) {
      return VisionApiResponse(
        success: false,
        error: 'Failed to parse response: $e',
      );
    }
  }
}

class VisionApiService {
  final String baseUrl;
  final http.Client _client;

  VisionApiService({http.Client? client})
      : baseUrl = dotenv.env['GC_API_BASE_URL'] ?? '',
        _client = client ?? http.Client();

  Future<VisionApiResponse> detectWeb({required String imagePath}) async {
    try {
      final file = File(imagePath);
      if (!await file.exists()) {
        return VisionApiResponse(
          success: false,
          error: 'Image file not found: $imagePath',
        );
      }

      // 画像をBase64エンコード
      final bytes = await file.readAsBytes();
      final base64Image = base64Encode(bytes);

      // リクエストボディを構築
      final requestBody = {
        "requests": [
          {
            "image": {
              "content": base64Image
            },
            "features": [
              {
                "type": "WEB_DETECTION"
              }
            ]
          }
        ]
      };

      final uri = Uri.parse('$baseUrl/api/v1/vision/web-detection');
      final response = await _client.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return VisionApiResponse.fromJson(responseData);
      } else {
        return VisionApiResponse(
          success: false,
          error: 'HTTP ${response.statusCode}: ${response.body}',
        );
      }
    } catch (e) {
      return VisionApiResponse(
        success: false,
        error: 'Request failed: $e',
      );
    }
  }

  void dispose() {
    _client.close();
  }
}