import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bizcard/db/database.dart';

final databaseProvider = Provider<Database>((ref) {
  return Database();
});