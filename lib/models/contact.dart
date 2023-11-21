import 'package:json_annotation/json_annotation.dart';

part 'contact.g.dart';

@JsonSerializable()
class Contact {
  String name;
  String email;
  String phone;
  static RegExp emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
  static RegExp phoneRegex = RegExp(r'^[+]?[(]?[0-9]{3}[)]?[-\s.]?[0-9]{3}[-\s.]?[0-9]{4,6}$');
  static RegExp nameRegex = RegExp(r'^[a-zA-Z]+$');

  Contact({
    required this.name,
    required this.email,
    required this.phone,
  });

  factory Contact.empty() => Contact(
    name: '',
    email: '',
    phone: '',
  );

  factory Contact.fromStrings(List<String> strings) {
    Contact contact = Contact.empty();
    contact.email = strings.firstWhere((element) => element.contains(emailRegex), orElse: () => '');
    contact.phone = strings.firstWhere((element) => element.contains(phoneRegex), orElse: () => '');
    contact.name = strings.firstWhere((element) => !element.contains(emailRegex) && !element.contains(phoneRegex), orElse: () => '');
    return contact;
  }

  factory Contact.fromJson(Map<String, dynamic> json) => _$ContactFromJson(json);
  Map<String, dynamic> toJson() => _$ContactToJson(this);

  bool isValid() {
    return emailRegex.hasMatch(email) && phoneRegex.hasMatch(phone) && nameRegex.hasMatch(name);
  }

  void format() {
    email = email.replaceAll(RegExp(r'\s'), '');
    phone = RegExp(r'\d+').allMatches(phone).map((e) => e.group(0)).join('');
    name = name.replaceAll(RegExp(r'\s'), '');
  }
}
