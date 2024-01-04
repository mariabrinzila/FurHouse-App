import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:furhouse_app/common/constants/colors.dart';

import 'package:furhouse_app/common/functions/modal_popup.dart';
import 'package:furhouse_app/common/functions/exception_code_handler.dart';

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
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  void _changeEmail(BuildContext context) async {
    var currentUser = Authentication().getCurrentUser();
    String currentUserEmail = currentUser?.email ?? "";

    var emailModalResult = await changeEmailModalPopup(
        context, currentUserEmail, _emailController);

    _emailController.clear();

    print(emailModalResult);
  }

  void _changePassword(BuildContext context) async {
    var passwordModalResult =
        await changePasswordModalPopup(context, _passwordController);

    _passwordController.clear();

    print(passwordModalResult);
  }

  void _changeFirstName(BuildContext context) async {
    var firstNameModalResult =
        await changeFirstNameModalPopup(context, _firstNameController);

    _firstNameController.clear();

    print(firstNameModalResult);
  }

  void _changeLastName(BuildContext context) async {
    var lastNameModalResult =
        await changeLastNameModalPopup(context, _lastNameController);

    _lastNameController.clear();

    print(lastNameModalResult);
  }

  @override
  Widget build(BuildContext context) {
    var trailingIcon = const Icon(
      CupertinoIcons.chevron_forward,
      color: Colors.white,
    );

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
          onTap: () {},
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
        SettingsListTile(
          onTap: () {},
          tileTitle: AppLocalizations.of(context)?.verifyEmail ?? "",
          leadingIcon: const Icon(
            Icons.mark_email_read_rounded,
            color: Colors.white,
          ),
          trailingIcon: null,
        ),
        SettingsListTile(
          onTap: () {},
          tileTitle: AppLocalizations.of(context)?.deleteAccount ?? "",
          leadingIcon: const Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
