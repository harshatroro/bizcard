import 'package:flutter/cupertino.dart';

class AlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final String actionText;
  final Function? callback;

  const AlertDialog({
    super.key,
    required this.title,
    required this.content,
    required this.actionText,
    this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        CupertinoDialogAction(
          child: Text(actionText),
          onPressed: () {
            Navigator.of(context).pop();
            if(callback != null) callback!();
          },
        ),
      ],
    );
  }
}
