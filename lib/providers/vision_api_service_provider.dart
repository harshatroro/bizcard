import 'package:bizcard/providers/vision_api_client_provider.dart';
import 'package:bizcard/services/google_vision_api_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final visionApiServiceProvider = FutureProvider<GoogleVisionApiService>((ref) async {
  final visionApi = await ref.watch(visionApiProvider.future);
  return GoogleVisionApiService(
    visionApi: visionApi,
  );
});