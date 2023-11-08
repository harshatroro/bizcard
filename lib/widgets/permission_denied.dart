import 'package:flutter/cupertino.dart';

class PermissionDenied extends StatelessWidget {
  const PermissionDenied({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      child: Center(
        child: Text(
          'Permission Denied',
          style: TextStyle(
            color: CupertinoColors.black,
            decoration: TextDecoration.none,
            fontSize: 20,
            fontFamily: 'SF Pro Display',
          ),
        ),
      ),
    );
  }
}
