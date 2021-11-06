import 'package:flutter/material.dart';

class AppliCationSuccessDialog extends StatelessWidget {
  const AppliCationSuccessDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Application Successfil!'),
      actions: [
        MaterialButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'Ok',
            style: TextStyle(fontSize: 15),
          ),
        ),
      ],
    );
  }
}
