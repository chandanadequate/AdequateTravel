import 'package:flutter/material.dart';

class Alerti {
  static showAlertDialog(BuildContext context, String title, String message) {
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () async {
            Navigator.pop(context, true);
          },
          child: Text(
            'OK',
          ),
        ),
      ],
    );
    showDialog(
        context: context,
        builder: (context) {
          return alert;
        });
  }
}
