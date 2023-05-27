import 'package:flutter/cupertino.dart';

import 'package:furhouse_app/common/widget_templates/cupertino_form_dialog.dart';

Widget _dialogBuilder(BuildContext context, String title, String content) {
  return CupertinoFormDialog(
    title: Text(
      title,
    ),
    content: Text(
      content,
    ),
  );
}

void loginExceptionHandler(BuildContext context, String exceptionCode) {
  var message = '';

  if (exceptionCode == 'wrong-password') {
    message = 'You entered the wrong password!';
  }

  if (exceptionCode == 'invalid-email') {
    message = 'The email you entered is invalid!';
  }

  if (exceptionCode == 'user-disabled') {
    message = 'The user is currently disabled!';
  }

  if (exceptionCode == 'user-not-fount') {
    message = 'The user was not found!';
  }

  if (message == '') {
    message = 'Signing in is currently unavailable!';
  }

  showCupertinoDialog(
    context: context,
    builder: (context) {
      return _dialogBuilder(context, 'Authentication error', message);
    },
  );
}

void registerExceptionHandler(BuildContext context, String exceptionCode) {
  var message = '';

  if (exceptionCode == 'email-already-in-use') {
    message = 'The email you entered is already in use!';
  }

  if (exceptionCode == 'invalid-email') {
    message = 'The email you entered is invalid!';
  }

  if (exceptionCode == 'operation-not-allowed') {
    message = 'Signing in with email and password is not currently allowed!';
  }

  if (exceptionCode == 'weak-password') {
    message = 'The password you entered is too weak!';
  }

  if (message == '') {
    message = 'Signing up is currently unavailable!';
  }

  showCupertinoDialog(
    context: context,
    builder: (context) {
      return _dialogBuilder(context, 'Authentication error', message);
    },
  );
}

void locationServicesExceptionHandler(
    BuildContext context, String exceptionCode) {
  var message = '';

  if (exceptionCode == 'disabled') {
    message = 'The location services on this device are currently disabled!';
  }

  if (exceptionCode == 'denied-forever') {
    message = 'The location services on this device are forever denied!';
  }

  if (exceptionCode == 'denied') {
    message = 'The location services on this device are currently denied!';
  }

  if (message == '') {
    message = 'Location services are currently unavailable!';
  }

  showCupertinoDialog(
    context: context,
    builder: (context) {
      return _dialogBuilder(context, 'Location services error', message);
    },
  );
}
