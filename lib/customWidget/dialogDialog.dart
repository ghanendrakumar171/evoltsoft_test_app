// ignore_for_file: file_names
import 'package:evolesoft_app/utils/appStrings.dart';
import 'package:flutter/material.dart';

renderBasicAlert({required BuildContext context, required String message}) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(AppStrings.dismiss),
          ),
        ],
      );
    },
  );
}

renderStandardlert({
  required BuildContext context,
  required String title,
  required String message,
  required String cancelButtonLabel,
}) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(cancelButtonLabel),
          ),
        ],
      );
    },
  );
}

class CustomSnackBar {
  static void show(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        content: Text(message, style: Theme.of(context).textTheme.bodySmall),
        duration: Duration(seconds: 3), // Adjust the duration as needed
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            // Perform any action on press if needed
          },
        ),
      ),
    );
  }
}
