import 'package:bizcard/models/contact.dart';
import 'package:bizcard/providers/repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final contactsProvider = FutureProvider<List<Contact>>((ref) async {
  final repository = ref.watch(repositoryProvider);
  final response = await repository.getContacts();
  return response;
});