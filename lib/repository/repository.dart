import 'package:bizcard/db/database.dart';
import 'package:bizcard/models/contact.dart';
import 'package:bizcard/services/google_vision_api_service.dart';

class Repository {
  final Database database;
  final GoogleVisionApiService visionApiService;

  Repository({
    required this.database,
    required this.visionApiService,
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

  Future<List<String>> readTextFromImage(String imagePath) async {
    List<String> strings = List<String>.empty(growable: true);
    strings = await visionApiService.readTextFromImage(imagePath);
    return strings;
  }
}