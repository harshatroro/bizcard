import 'package:bizcard/db/database.dart';
import 'package:bizcard/models/contact.dart';

class Repository {
  final Database database;

  Repository({
    required this.database,
  });

  Future<List<Contact>> getContacts() async {
    final contactsJson = await database.queryAllRows();
    final contacts = contactsJson.map((json) => Contact.fromJson(json)).toList();
    return contacts;
  }

  Future<int> saveContact(Contact contact) async {
    final response = await database.insert(contact.toJson());
    return response;
  }
}