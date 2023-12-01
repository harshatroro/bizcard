import 'package:bizcard/bert/bert_question_answerer.dart';
import 'package:bizcard/bert/qa_answer.dart';
import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

part 'contact.g.dart';

@JsonSerializable()
class Contact {
  String name;
  String email;
  String phone;
  String address;
  static RegExp phoneRegex = RegExp(r'\+?\d[(\d)\ \-\(\)]{8,15}');
  static RegExp emailRegex = RegExp(r'[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}');
  BertQuestionAnswerer? _answerer;

  Contact({
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
  });

  factory Contact.empty() => Contact(
    name: '',
    email: '',
    phone: '',
    address: '',
  );

  Future<void> initializeBert() async {
    _answerer = await BertQuestionAnswerer.createFromAsset('lib/assets/model.tflite');
  }

  Future<void> assignValuesUsingString(String string) async {
    email = emailRegex.firstMatch(string)?.group(0) ?? '';
    phone = phoneRegex.firstMatch(string)?.group(0) ?? '';
    string = string.replaceAll('\n', ' ');
    if(_answerer == null) {
      await initializeBert();
    }
    List<QaAnswer> names = _answerer!.answer(string, 'What is the name of the person?');
    List<QaAnswer> addresses = _answerer!.answer(string, 'What is the location?');
    if(names.isNotEmpty) {
      name = names.first.text;
      debugPrint('Name: $name');
    }
    if(addresses.isNotEmpty) {
      address = addresses.first.text;
      debugPrint('Address: $address');
    }
  }

  factory Contact.fromJson(Map<String, dynamic> json) => _$ContactFromJson(json);
  Map<String, dynamic> toJson() => _$ContactToJson(this);

  bool isValid() {
    return emailRegex.hasMatch(email) && phoneRegex.hasMatch(phone);
  }

  void format() {
    email = email.replaceAll(RegExp(r'\s'), '');
    phone = phone.replaceAll(RegExp(r'[a-zA-Z\-()\s]'), '');
    debugPrint('Formatted mobile number: $phone');
    debugPrint('Formatted email: $email');
  }
}
