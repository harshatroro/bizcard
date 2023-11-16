import 'package:bizcard/models/contact.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final contactProvider = StateProvider<Contact>((ref) => Contact.empty());