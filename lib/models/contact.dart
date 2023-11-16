import 'package:json_annotation/json_annotation.dart';

part 'contact.g.dart';

@JsonSerializable()
class Contact {
  String name;
  String email;
  String phone;

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

  factory Contact.fromJson(Map<String, dynamic> json) => _$ContactFromJson(json);
  Map<String, dynamic> toJson() => _$ContactToJson(this);

  bool isValid() {
    RegExp emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    RegExp phoneRegex = RegExp(r'^[0-9]+$');
    RegExp nameRegex = RegExp(r'^[a-zA-Z]+$');
    return emailRegex.hasMatch(email) && phoneRegex.hasMatch(phone) && nameRegex.hasMatch(name);
  }
}
