import 'package:flutter/cupertino.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:furhouse_app/common/widget_templates/cupertino_form_dialog.dart';

import 'package:furhouse_app/services/pets.dart';

void _toggleValidationAlert(
    BuildContext context, Widget title, Widget content) {
  showCupertinoDialog(
    context: context,
    builder: (context) {
      return CupertinoFormDialog(
        title: title,
        content: content,
      );
    },
  );
}

bool emailValidation(String email, BuildContext context) {
  if (email.isEmpty) {
    _toggleValidationAlert(
      context,
      const Text(
        "Empty email",
      ),
      const Text(
        "The email must not be empty!",
      ),
    );

    return true;
  }

  if (!EmailValidator.validate(email)) {
    _toggleValidationAlert(
      context,
      const Text(
        "Incorrect email",
      ),
      const Text(
        "The email must have the correct format, for example johnDoe@gmail.com!",
      ),
    );

    return true;
  }

  return false;
}

bool nameValidation(String name, String nameType, BuildContext context) {
  if (name.isEmpty) {
    _toggleValidationAlert(
      context,
      Text(
        AppLocalizations.of(context)?.emptyNameTitle ?? "",
      ),
      Text(
        "$nameType ${AppLocalizations.of(context)?.emptyName ?? ""}",
      ),
    );

    return true;
  }

  if (name.length < 2) {
    _toggleValidationAlert(
      context,
      Text(
        AppLocalizations.of(context)?.shortNameTitle ?? "",
      ),
      Text(
        "$nameType ${AppLocalizations.of(context)?.shortName ?? ""}",
      ),
    );

    return true;
  }

  var hasUpperCase = name.contains(RegExp(r"[A-Z]"));

  if (!hasUpperCase) {
    _toggleValidationAlert(
      context,
      Text(
        AppLocalizations.of(context)?.incorrectNameTitle ?? "",
      ),
      Text(
        "$nameType ${AppLocalizations.of(context)?.incorrectName ?? ""}",
      ),
    );

    return true;
  }

  return false;
}

bool passwordValidation(String password, BuildContext context) {
  if (password.isEmpty) {
    _toggleValidationAlert(
      context,
      const Text(
        "Empty password",
      ),
      const Text(
        "The password must not be empty!",
      ),
    );

    return true;
  }

  if (password.length < 8) {
    _toggleValidationAlert(
      context,
      const Text(
        "Short password",
      ),
      const Text(
        "The password must be at least 8 characters in length!",
      ),
    );

    return true;
  }

  var hasLowerCase = password.contains(RegExp(r"[a-z]"));

  if (!hasLowerCase) {
    _toggleValidationAlert(
      context,
      const Text(
        "Password not complex enough",
      ),
      const Text(
        "The password must contain at least one lower case character!",
      ),
    );

    return true;
  }

  var hasUpperCase = password.contains(RegExp(r"[A-Z]"));

  if (!hasUpperCase) {
    _toggleValidationAlert(
      context,
      const Text(
        "Password not complex enough",
      ),
      const Text(
        "The password must contain at least one upper case character!",
      ),
    );

    return true;
  }

  var hasDigit = password.contains(RegExp(r"[0-9]"));

  if (!hasDigit) {
    _toggleValidationAlert(
      context,
      const Text(
        "Password not complex enough",
      ),
      const Text(
        "The password must contain at least one digit!",
      ),
    );

    return true;
  }

  var hasSpecialCharacter = password.contains(RegExp(r"[!*-+=~]"));

  if (!hasSpecialCharacter) {
    _toggleValidationAlert(
      context,
      const Text(
        "Password not complex enough",
      ),
      const Text(
        "The password must contain at least one special character (!, *, -, +, =, ~)!",
      ),
    );

    return true;
  }

  return false;
}

bool confirmPasswordValidation(
    String password, String confirmedPassword, BuildContext context) {
  if (confirmedPassword.isEmpty) {
    _toggleValidationAlert(
      context,
      const Text(
        "Empty password",
      ),
      const Text(
        "The confirmed password must not be empty!",
      ),
    );

    return true;
  }

  if (password.length != confirmedPassword.length ||
      password != confirmedPassword) {
    _toggleValidationAlert(
      context,
      const Text(
        "Different password",
      ),
      const Text(
        "The password and the confirmed password must match!",
      ),
    );

    return true;
  }

  return false;
}

bool nonEmptyField(String fieldValue, String field, BuildContext context) {
  if (fieldValue.isEmpty) {
    _toggleValidationAlert(
      context,
      Text(
        AppLocalizations.of(context)?.emptyFieldTitle ?? "",
      ),
      Text(
        "$field ${AppLocalizations.of(context)?.emptyField ?? ""}",
      ),
    );

    return true;
  }

  return false;
}

Future<bool> uniqueNameValidation(
    String name, String nameType, BuildContext context) async {
  if (nameValidation(name, nameType, context)) {
    return true;
  }

  final petNameExists = await Pets().petNameAlreadyExists(name);

  if (petNameExists && context.mounted) {
    _toggleValidationAlert(
      context,
      const Text(
        "Duplicate name",
      ),
      Text(
        "The $nameType name already exists!",
      ),
    );

    return true;
  }

  return false;
}

bool onlyCharactersTextField(
    String fieldValue, String field, BuildContext context) {
  if (fieldValue.isNotEmpty) {
    if (fieldValue.length < 2) {
      _toggleValidationAlert(
        context,
        Text(
          "Short $field",
        ),
        Text(
          "The $field must be at least 2 characters in length!",
        ),
      );

      return true;
    }

    var hasDigit = fieldValue.contains(RegExp(r"[0-9]"));

    if (hasDigit) {
      _toggleValidationAlert(
        context,
        Text(
          "Wrong $field",
        ),
        Text(
          "The $field must only contain upper and lower case characters!",
        ),
      );

      return true;
    }

    var hasSpecialCharacter =
        fieldValue.contains(RegExp(r'[~`!@#$%^&*()_+-={[}]|\:;"<,>.?/}]/'));

    if (hasSpecialCharacter) {
      _toggleValidationAlert(
        context,
        Text(
          "Wrong $field",
        ),
        Text(
          "The $field must only contain upper and lower case characters!",
        ),
      );

      return true;
    }
  }

  return false;
}
