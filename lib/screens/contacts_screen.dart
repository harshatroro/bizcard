import 'package:auto_route/annotations.dart';
import 'package:bizcard/models/contact.dart';
import 'package:bizcard/providers/repository_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class ContactsScreen extends ConsumerStatefulWidget {
  const ContactsScreen({super.key});

  @override
  ConsumerState<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends ConsumerState<ContactsScreen> {
  List<Contact> contacts = List<Contact>.empty(growable: true);

  List<Widget> generateContactTiles(contacts) {
    List<Widget> contactTiles = List<Widget>.empty(growable: true);
    for (var contact in contacts) {
      contactTiles.add(
        CupertinoListTile(
          title: Text(contact.name),
          subtitle: Text(contact.email),
          trailing: CupertinoButton(
            child: const Icon(CupertinoIcons.right_chevron),
            onPressed: () {
            //   TODO: Add navigation to contact details screen
            },
          ),
        ),
      );
    }
    return contactTiles;
  }

  void fetchContacts() async {
    final contactsList = await ref.read(contactsListProvider.future);
    setState(() {
      contacts = contactsList;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchContacts();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Contacts'),
      ),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: contacts.isEmpty
              ? MainAxisAlignment.center
              : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: contacts.isEmpty
              ? const [
                  Center(
                    child: Text('No contacts yet'),
                  ),
                ]
              : generateContactTiles(contacts)
        ),
      ),
    );
  }
}
