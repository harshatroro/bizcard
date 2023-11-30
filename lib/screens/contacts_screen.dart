import 'package:auto_route/annotations.dart';
import 'package:bizcard/providers/contacts_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class ContactsScreen extends ConsumerStatefulWidget {
  const ContactsScreen({super.key});

  @override
  ConsumerState<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends ConsumerState<ContactsScreen> {
  List<Widget> generateContactTiles(contacts) {
    List<Widget> contactTiles = List<Widget>.empty(growable: true);
    for (var contact in contacts) {
      contactTiles.add(
        CupertinoListTile(
          onTap: () {

          },
          backgroundColorActivated: CupertinoColors.systemGrey5,
          title: Text(contact.name),
          subtitle: Text("${contact.phone} | ${contact.email}"),
        ),
      );
    }
    return contactTiles;
  }

  @override
  Widget build(BuildContext context) {
    final contacts = ref.watch(contactsProvider.future);
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Contacts'),
      ),
      child: SafeArea(
        child: FutureBuilder(
          future: contacts,
          builder: (context, snapshot) {
            if(
              snapshot.connectionState == ConnectionState.waiting ||
              snapshot.connectionState == ConnectionState.active
            ) {
              return const Center(
                child: CupertinoActivityIndicator(),
              );
            } else {
              if(snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              } else {
                if(snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text(
                      'No contacts found',
                      style: TextStyle(
                        fontSize: 16,
                        color: CupertinoColors.systemGrey,
                      ),
                    ),
                  );
                }
                return ListView(
                  children: generateContactTiles(snapshot.data),
                );
              }
            }
          },
        ),
      ),
    );
  }
}
