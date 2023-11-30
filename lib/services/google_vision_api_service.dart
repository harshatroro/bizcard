import 'dart:convert';
import 'dart:io';
import 'package:googleapis/vision/v1.dart';

class GoogleVisionApiService {
  final VisionApi visionApi;

  GoogleVisionApiService({
    required this.visionApi,
  });

  Future<String> readTextFromImage(String imagePath) async {
    List<int> imageBytes = await File(imagePath).readAsBytes();
    String base64Image = base64Encode(imageBytes);
    final response = await visionApi.images.annotate(
      BatchAnnotateImagesRequest.fromJson({
        "requests": [
          {
            "image": {
              "content": base64Image,
            },
            "features": [
              {
                "type": "TEXT_DETECTION",
              }
            ]
          }
        ]
      }),
    );

    if (response.responses != null && response.responses!.isNotEmpty) {
      final textAnnotations = response.responses![0].textAnnotations;
      if (textAnnotations != null && textAnnotations.isNotEmpty) {
        String extractedText = textAnnotations[0].description ?? 'No text found';
        return extractedText;
      }
    }
    return '';
  }
}