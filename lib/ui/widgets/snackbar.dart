import 'package:flutter/material.dart';

void showSnackbar(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        'Oops.. ada yang salah nih',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      backgroundColor: Colors.red,
      behavior: SnackBarBehavior.floating,
    ),
  );
}
