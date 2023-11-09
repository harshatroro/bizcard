import 'package:bizcard/models/contact.dart';
import 'package:bizcard/providers/database_provider.dart';
import 'package:bizcard/repository/repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final repositoryProvider = Provider<Repository>((ref) {
  final database = ref.watch(databaseProvider);
  return Repository(database: database);
});

final contactsListProvider = FutureProvider<List<Contact>>((ref) async {
  final repository = ref.watch(repositoryProvider);
  return await repository.getContacts();
});