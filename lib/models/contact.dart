import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

part 'contact.g.dart';

@JsonSerializable()
class Contact {
  String name;
  String email;
  String phone;
  static RegExp emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
  static RegExp phoneRegex = RegExp(r'^[+]?[(]?[0-9]{3}[)]?[-\s.]?[0-9]{3}[-\s.]?[0-9]{4,6}$');
  static RegExp nameRegex = RegExp(r'^[a-zA-Z]+$');

  MethodChannel? _channel;

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

  Future<void> setupChannel(MethodChannel channel) async {
    _channel = const MethodChannel('mobilebert');
    final appDocumentsDirectory = await getApplicationDocumentsDirectory();
    await _channel!.invokeMethod('initializeMobilebert', {
      'path': '${appDocumentsDirectory.path}/assets/model.tflite',
    });
  }

  Future<void> assignValuesUsingString(String string) async {
    List<String> strings = string.split('\n');
    email = strings.firstWhere((element) => element.contains(emailRegex), orElse: () => '');
    phone = strings.firstWhere((element) => element.contains(phoneRegex), orElse: () => '');
    List<String> names = await _channel!.invokeMethod('answer', {
      'context': string,
      'question': 'What is the name of the person?',
    });
    if(names.isNotEmpty) {
      name = names.first;
    }
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
