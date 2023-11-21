import 'package:auto_route/auto_route.dart';
import 'package:bizcard/models/contact.dart';
import 'package:bizcard/providers/contact_provider.dart';
import 'package:bizcard/providers/repository_provider.dart';
import 'package:bizcard/widgets/alert_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class NewContactScreen extends ConsumerStatefulWidget {
  final Contact contact;

  const NewContactScreen({
    super.key,
    required this.contact,
  });

  @override
  ConsumerState<NewContactScreen> createState() => _NewContactScreenState();
}

class _NewContactScreenState extends ConsumerState<NewContactScreen> {
  @override
  Widget build(BuildContext context) {
    Contact contact = widget.contact;
    return CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
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
                    controller: TextEditingController(text: contact.name),
                    placeholder: 'Enter name',
                    onChanged: (String value) {
                      setState(() {
                        contact.name = value;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CupertinoTextField(
                    controller: TextEditingController(text: contact.email),
                    placeholder: 'Enter email',
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (String value) {
                      setState(() {
                        contact.email = value;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CupertinoTextField(
                    controller: TextEditingController(text: contact.phone),
                    placeholder: 'Enter phone number',
                    keyboardType: TextInputType.number,
                    onChanged: (String value) {
                      setState(() {
                        contact.phone = value;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CupertinoButton(
                    color: CupertinoColors.activeBlue,
                    padding: const EdgeInsets.all(8.0),
                    onPressed: () {
                      if (contact.isValid()) {
                        debugPrint("Contact is valid");
                        final repository = ref.read(repositoryProvider.future);
                        repository.then((repository) {
                          final response = repository.saveContact(contact);
                          response.then((value) {
                            if (value == 0) {
                              debugPrint("Error saving contact");
                              showCupertinoDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    const AlertDialog(
                                  title: "Error",
                                  content: "Unable to save contact.",
                                  actionText: "Okay",
                                ),
                              );
                            } else {
                              debugPrint("Contact saved successfully");
                              showCupertinoDialog(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                    title: "Success",
                                    content: "Contact saved successfully.",
                                    actionText: "Okay",
                                    callback: () => {
                                          ref
                                              .read(contactProvider.notifier)
                                              .state = Contact.empty(),
                                          context.router.back()
                                        }),
                              );
                            }
                          });
                        });
                      } else {
                        debugPrint("Contact is invalid");
                        showCupertinoDialog(
                          context: context,
                          builder: (BuildContext context) => const AlertDialog(
                              title: "Error",
                              content: "Please enter valid details.",
                              actionText: "Okay"),
                        );
                      }
                    },
                    child: const Text('Create Contact'),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
