import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:furhouse_app/main_display.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:furhouse_app/common/constants/colors.dart';
import 'package:furhouse_app/common/constants/others.dart';

import 'package:furhouse_app/common/functions/modal_popup.dart';
import 'package:furhouse_app/common/functions/exception_code_handler.dart';
import 'package:furhouse_app/common/functions/form_validation.dart';
import 'package:furhouse_app/common/functions/confirm_action.dart';

import 'package:furhouse_app/common/widget_templates/settings_list_tile.dart';

import 'package:furhouse_app/services/authentication.dart';

class Account extends StatefulWidget {
  const Account({
    super.key,
  });

  @override
  State<StatefulWidget> createState() {
    return _AccountState();
  }
}

class _AccountState extends State<Account> {
  Timer? timer;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  bool isEmailVerified = false;

  @override
  void initState() {
    timer = Timer.periodic(
        const Duration(
          seconds: 10,
        ), (timer) {
      checkEmailVerification();
    });

    super.initState();
  }

  void _changeEmail(BuildContext context) async {
    var currentUser = Authentication().getCurrentUser();
    String currentUserEmail = currentUser?.email ?? "";

    var emailModalResult = await changeEmailModalPopup(
        context, currentUserEmail, _emailController);

    _emailController.clear();

    String? oldPasswordModalResult;

    if (context.mounted &&
        emailModalResult != null &&
        emailModalResult != "cancel") {
      oldPasswordModalResult = await changePasswordModalPopup(
          context, _oldPasswordController, false);

      _oldPasswordController.clear();
    }

    if (emailModalResult != null &&
        emailModalResult != "cancel" &&
        oldPasswordModalResult != null &&
        oldPasswordModalResult != "cancel") {
      if (context.mounted) {
        if (emailValidation(emailModalResult, context)) return;
      }

      // update first name in the database
      var updateFieldMessage = await Authentication()
          .updateUserEmail(emailModalResult, oldPasswordModalResult);

      if (updateFieldMessage != "Success") {
        if (context.mounted) {
          registerExceptionHandler(context, updateFieldMessage);
        }
      } else {
        if (notificationService != null) {
          await notificationService?.showLocalNotification(
            id: currentNotificationID,
            title: "Updated email",
            body: "You have just updated your email!",
            payload: "Your email has been changed",
          );

          currentNotificationID++;
        }

        if (context.mounted) _navigateToLanding(context);
      }
    }
  }

  void _navigateToLanding(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MainDisplay(),
      ),
    );
  }

  void _changePassword(BuildContext context) async {
    var passwordModalResult =
        await changePasswordModalPopup(context, _passwordController, true);

    _passwordController.clear();

    String? oldPasswordModalResult;

    if (context.mounted &&
        passwordModalResult != null &&
        passwordModalResult != "cancel") {
      oldPasswordModalResult = await changePasswordModalPopup(
          context, _oldPasswordController, false);

      _oldPasswordController.clear();
    }

    if (passwordModalResult != null &&
        passwordModalResult != "cancel" &&
        oldPasswordModalResult != null &&
        oldPasswordModalResult != "cancel") {
      if (context.mounted) {
        if (passwordValidation(passwordModalResult, context)) return;
      }

      // update first name in the database
      var updateFieldMessage = await Authentication()
          .updatePassword(passwordModalResult, oldPasswordModalResult);

      if (updateFieldMessage != "Success") {
        if (context.mounted) {
          registerExceptionHandler(context, updateFieldMessage);
        }
      } else {
        if (notificationService != null) {
          await notificationService?.showLocalNotification(
            id: currentNotificationID,
            title: "Updated password",
            body: "You have just updated your password!",
            payload: "Your password has been changed",
          );

          currentNotificationID++;
        }

        if (context.mounted) _navigateToLanding(context);
      }
    }
  }

  void _changeBirthday(BuildContext context) async {
    var currentUser = Authentication().getCurrentUser();
    String currentUserEmail = currentUser?.email ?? "";

    var getBirthdayMessage = await Authentication()
        .getInformationForUser(currentUserEmail, "birthday");

    if (getBirthdayMessage.contains("Success")) {
      var getBirthdayArray = getBirthdayMessage.split(":");

      if (getBirthdayArray.length < 2) return;

      var previousBirthday = getBirthdayArray[1];

      if (context.mounted) {
        var birthdayModalResult = await changeBirthdayModalPopup(
            context, _birthdayController, previousBirthday);

        _birthdayController.clear();

        if (birthdayModalResult != null && birthdayModalResult != "cancel") {
          if (context.mounted) {
            if (nonEmptyField(birthdayModalResult, "birthday", context)) return;
          }

          // update first name in the database
          var updateFieldMessage =
              await Authentication().updateBirthday(birthdayModalResult);

          if (updateFieldMessage != "Success") {
            if (context.mounted) {
              registerExceptionHandler(context, updateFieldMessage);
            }
          } else {
            if (notificationService != null) {
              await notificationService?.showLocalNotification(
                id: currentNotificationID,
                title: "Updated birthday",
                body: "You have just updated your birthday!",
                payload: "Your birthday has been changed",
              );

              currentNotificationID++;
            }
          }
        }
      }
    } else {
      if (context.mounted) {
        otherExceptionsHandler(context, getBirthdayMessage);

        return;
      }
    }
  }

  void _changeFirstName(BuildContext context) async {
    var currentUser = Authentication().getCurrentUser();
    String currentUserEmail = currentUser?.email ?? "";

    // get the user's current first name from the database
    var getFirstNameMessage = await Authentication()
        .getInformationForUser(currentUserEmail, "first_name");

    if (getFirstNameMessage.contains("Success")) {
      var getFirstNameArray = getFirstNameMessage.split(":");

      if (getFirstNameArray.length < 2) return;

      var previousFirstName = getFirstNameArray[1];

      if (context.mounted) {
        var firstNameModalResult = await changeFirstNameModalPopup(
            context, _firstNameController, previousFirstName);

        _firstNameController.clear();

        if (firstNameModalResult != null && firstNameModalResult != "cancel") {
          if (context.mounted) {
            if (nameValidation(firstNameModalResult, "first", context)) return;
          }

          // update first name in the database
          var updateFieldMessage =
              await Authentication().updateFirstName(firstNameModalResult);

          if (updateFieldMessage != "Success") {
            if (context.mounted) {
              registerExceptionHandler(context, updateFieldMessage);
            }
          } else {
            if (notificationService != null) {
              await notificationService?.showLocalNotification(
                id: currentNotificationID,
                title: "Updated first name",
                body: "You have just updated your first name!",
                payload: "Your first name has been changed",
              );

              currentNotificationID++;
            }
          }
        }
      }
    } else {
      if (context.mounted) {
        otherExceptionsHandler(context, getFirstNameMessage);

        return;
      }
    }
  }

  void _changeLastName(BuildContext context) async {
    var currentUser = Authentication().getCurrentUser();
    String currentUserEmail = currentUser?.email ?? "";

    var getLastNameMessage = await Authentication()
        .getInformationForUser(currentUserEmail, "last_name");

    if (getLastNameMessage.contains("Success")) {
      var getLastNameArray = getLastNameMessage.split(":");

      if (getLastNameArray.length < 2) return;

      var previousLastName = getLastNameArray[1];

      if (context.mounted) {
        var lastNameModalResult = await changeLastNameModalPopup(
            context, _lastNameController, previousLastName);

        _lastNameController.clear();

        if (lastNameModalResult != null && lastNameModalResult != "cancel") {
          if (context.mounted) {
            if (nameValidation(lastNameModalResult, "last", context)) return;
          }

          // update first name in the database
          var updateFieldMessage =
              await Authentication().updateLastName(lastNameModalResult);

          if (updateFieldMessage != "Success") {
            if (context.mounted) {
              registerExceptionHandler(context, updateFieldMessage);
            }
          } else {
            if (notificationService != null) {
              await notificationService?.showLocalNotification(
                id: currentNotificationID,
                title: "Updated last name",
                body: "You have just updated your last name!",
                payload: "Your last name has been changed",
              );

              currentNotificationID++;
            }
          }
        }
      }
    } else {
      if (context.mounted) {
        otherExceptionsHandler(context, getLastNameMessage);

        return;
      }
    }
  }

  void _verifyEmail(BuildContext context) async {
    var verifyEmailMessage = await Authentication().verifyEmail();

    if (verifyEmailMessage != "Success") {
      if (context.mounted) {
        otherExceptionsHandler(context, verifyEmailMessage);
      }
    } else {
      if (context.mounted) {
        actionDoneDialog(context, "A verification email has been sent to you!");
      }
    }
  }

  void checkEmailVerification() async {
    await Authentication().checkIfEmailIsVerified();

    var currentUser = Authentication().getCurrentUser();

    setState(() {
      isEmailVerified = currentUser?.emailVerified ?? false;
    });

    if (isEmailVerified) {
      timer?.cancel();
    }
  }

  void _deleteAccount(BuildContext context) async {
    final confirmed = await confirmActionDialog(
        context, "Are you sure you want to delete your account?");

    if (confirmed == "no") {
      return;
    }

    String? oldPasswordModalResult;

    if (context.mounted) {
      oldPasswordModalResult = await changePasswordModalPopup(
          context, _oldPasswordController, false);

      _oldPasswordController.clear();
    }

    if (oldPasswordModalResult != null && oldPasswordModalResult != "cancel") {
      // delete account
      var deleteAccountMessage =
          await Authentication().deleteAccount(oldPasswordModalResult);

      if (deleteAccountMessage != "Success") {
        if (context.mounted) {
          registerExceptionHandler(context, deleteAccountMessage);
        }
      } else {
        if (notificationService != null) {
          await notificationService?.showLocalNotification(
            id: currentNotificationID,
            title: "Deleted account",
            body: "You have just deleted your account!",
            payload: "Your account has been deleted",
          );

          currentNotificationID++;
        }

        if (context.mounted) _navigateToLanding(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var trailingIcon = const Icon(
      CupertinoIcons.chevron_forward,
      color: Colors.white,
    );

    var currentUser = Authentication().getCurrentUser();
    var isEmailVerified = currentUser?.emailVerified ?? false;

    return ListView(
      padding: const EdgeInsets.only(
        top: 15,
        right: 5,
        left: 5,
        bottom: 5,
      ),
      children: [
        const SizedBox(
          height: 5,
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                lighterBlueColor,
                lightBlueColor,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(
                15,
              ),
            ),
          ),
          padding: const EdgeInsets.only(
            top: 5,
            bottom: 5,
            left: 10,
          ),
          child: Text(
            AppLocalizations.of(context)?.changeAccount ?? "",
            style: GoogleFonts.montserrat(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        SettingsListTile(
          onTap: () {
            _changeEmail(context);
          },
          tileTitle: AppLocalizations.of(context)?.email ?? "",
          leadingIcon: const Icon(
            Icons.email,
            color: Colors.white,
          ),
          trailingIcon: trailingIcon,
        ),
        SettingsListTile(
          onTap: () {
            _changePassword(context);
          },
          tileTitle: AppLocalizations.of(context)?.password ?? "",
          leadingIcon: const Icon(
            Icons.password,
            color: Colors.white,
          ),
          trailingIcon: trailingIcon,
        ),
        SettingsListTile(
          onTap: () {
            _changeBirthday(context);
          },
          tileTitle: AppLocalizations.of(context)?.birthday ?? "",
          leadingIcon: const Icon(
            Icons.calendar_month,
            color: Colors.white,
          ),
          trailingIcon: trailingIcon,
        ),
        SettingsListTile(
          onTap: () {
            _changeFirstName(context);
          },
          tileTitle: AppLocalizations.of(context)?.firstName ?? "",
          leadingIcon: const Icon(
            Icons.person,
            color: Colors.white,
          ),
          trailingIcon: trailingIcon,
        ),
        SettingsListTile(
          onTap: () {
            _changeLastName(context);
          },
          tileTitle: AppLocalizations.of(context)?.lastName ?? "",
          leadingIcon: const Icon(
            Icons.person,
            color: Colors.white,
          ),
          trailingIcon: trailingIcon,
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                lighterBlueColor,
                lightBlueColor,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(
                15,
              ),
            ),
          ),
          padding: const EdgeInsets.only(
            top: 5,
            bottom: 5,
            left: 10,
          ),
          child: Text(
            AppLocalizations.of(context)?.otherActions ?? "",
            style: GoogleFonts.montserrat(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        if (!isEmailVerified) ...[
          SettingsListTile(
            onTap: () {
              _verifyEmail(context);
            },
            tileTitle: AppLocalizations.of(context)?.verifyEmail ?? "",
            leadingIcon: const Icon(
              Icons.mark_email_read_rounded,
              color: Colors.white,
            ),
            trailingIcon: null,
          ),
        ],
        SettingsListTile(
          onTap: () {
            _deleteAccount(context);
          },
          tileTitle: AppLocalizations.of(context)?.deleteAccount ?? "",
          leadingIcon: const Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    timer?.cancel();

    super.dispose();
  }
}
