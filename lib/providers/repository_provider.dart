import 'package:bizcard/providers/database_provider.dart';
import 'package:bizcard/providers/vision_api_service_provider.dart';
import 'package:bizcard/repository/repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final repositoryProvider = FutureProvider<Repository>((ref) async {
  final database = ref.watch(databaseProvider);
  final googleVisionApiService = await ref.watch(visionApiServiceProvider.future);
  return Repository(database: database, visionApiService: googleVisionApiService);
});