import 'package:auto_route/annotations.dart';
import 'package:flutter/cupertino.dart';

@RoutePage()
class NewContactScreen extends StatefulWidget {
  const NewContactScreen({super.key});

  @override
  State<NewContactScreen> createState() => _NewContactScreenState();
}

class _NewContactScreenState extends State<NewContactScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String name = '';
  String email = '';
  int phone = 0;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar:  const CupertinoNavigationBar(
        middle: Text('New Contact'),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CupertinoTextField(
                  placeholder: 'Enter name',
                  controller: _nameController,
                  onChanged: (String value) {
                    setState(() {
                      name = value;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CupertinoTextField(
                  placeholder: 'Enter email',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (String value) {
                    setState(() {
                      email = value;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CupertinoTextField(
                  placeholder: 'Enter phone number',
                  controller: _phoneController,
                  keyboardType: TextInputType.number,
                  onChanged: (String value) {
                    try {
                      int valueInInt = int.parse(value);
                      setState(() {
                        phone = valueInInt;
                      });
                    } on Exception catch (e) {
                      debugPrint(e.toString());
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CupertinoButton(
                  color: CupertinoColors.activeBlue,
                  padding: const EdgeInsets.all(8.0),
                  onPressed: () {},
                  child: const Text('Create Contact'),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}
