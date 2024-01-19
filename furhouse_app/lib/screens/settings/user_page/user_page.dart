import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:furhouse_app/screens/settings/your_pets/your_pets_theme.dart';
import 'package:furhouse_app/screens/settings/your_pets/your_pets.dart';
import 'package:furhouse_app/screens/home/home.dart';

import 'package:furhouse_app/common/constants/colors.dart';
import 'package:furhouse_app/common/constants/others.dart';

import 'package:furhouse_app/common/functions/exception_code_handler.dart';
import 'package:furhouse_app/common/functions/confirm_action.dart';

import 'package:furhouse_app/common/widget_templates/settings_list_tile.dart';

import 'package:furhouse_app/models/user_VM.dart';

import 'package:furhouse_app/services/users.dart';
import 'package:furhouse_app/services/pets.dart';

class UserPage extends StatefulWidget {
  final UserVM currentUser;

  const UserPage({
    super.key,
    required this.currentUser,
  });

  @override
  State<UserPage> createState() {
    return _UserPageState();
  }
}

class _UserPageState extends State<UserPage> {
  int? addedPets;
  int? adoptedPets;

  @override
  void initState() {
    _getNumberAddedOfPets().then((value) {
      setState(() {
        addedPets = value ?? 0;
      });
    });

    _getNumberAdopedOfPets().then((value) {
      setState(() {
        adoptedPets = value ?? 0;
      });
    });

    super.initState();
  }

  Future<int?> _getNumberAddedOfPets() async {
    return await Pets().readNumberOfAddedPets(widget.currentUser.email);
  }

  Future<int?> _getNumberAdopedOfPets() async {
    return await Pets().readNumberOfAdoptedPets(widget.currentUser.email);
  }

  void _navigateToYourPets(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => YourPetsTheme(
          childWidget: YourPets(
            userEmail: widget.currentUser.email,
          ),
        ),
      ),
    );
  }

  void _makeAdmin(BuildContext contenxt) async {
    final confirmed = await confirmActionDialog(context,
        "Are you sure you want to make ${widget.currentUser.email} an admin?");

    if (confirmed == "no") {
      return;
    }

    var updateFieldMessage =
        await Users().updateAdmin(widget.currentUser.email);

    if (updateFieldMessage != "Success") {
      if (context.mounted) {
        registerExceptionHandler(context, updateFieldMessage);
      }
    } else {
      if (notificationService != null) {
        await notificationService?.showLocalNotification(
          id: currentNotificationID,
          title: "Changed user into admin",
          body: "${widget.currentUser.email} is now an admin!",
          payload: "The user is now an admin",
        );

        currentNotificationID++;
      }

      if (context.mounted) {
        _navigateToSettings(contenxt);
      }
    }
  }

  void _navigateToSettings(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const Home(
          selectedTabIndex: 2,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (addedPets == null || adoptedPets == null) {
      return Center(
        child: CupertinoActivityIndicator(
          color: darkerBlueColor,
          radius: 30,
        ),
      );
    }

    var trailingIcon = const Icon(
      CupertinoIcons.chevron_forward,
      color: Colors.white,
    );

    var trailingIconAddedPets = addedPets == 0 ? null : trailingIcon;
    var trailingIconAdoptedPets = adoptedPets == 0 ? null : trailingIcon;

    var addedPetsEnabled = addedPets == 0 ? false : true;
    var adoptedPetsEnabled = adoptedPets == 0 ? false : true;

    var trailingIconAction = const Icon(
      Icons.donut_large,
      color: Colors.white,
    );

    return ListView(
      padding: const EdgeInsets.only(
        top: 10,
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
            AppLocalizations.of(context)?.userInformation ?? "",
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
          tileTitle:
              "${widget.currentUser.firstName} ${widget.currentUser.lastName}",
          isTileEnabled: false,
          leadingIcon: const Icon(
            Icons.person,
            color: Colors.white,
          ),
        ),
        SettingsListTile(
          onTap: () {},
          tileTitle: widget.currentUser.email,
          isTileEnabled: false,
          leadingIcon: const Icon(
            Icons.email,
            color: Colors.white,
          ),
        ),
        SettingsListTile(
          onTap: () {},
          tileTitle: widget.currentUser.birthday,
          isTileEnabled: false,
          leadingIcon: const Icon(
            Icons.calendar_month,
            color: Colors.white,
          ),
        ),
        if (widget.currentUser.admin) ...[
          SettingsListTile(
            onTap: () {},
            tileTitle: "Admin",
            isTileEnabled: false,
            leadingIcon: const Icon(
              Icons.admin_panel_settings_outlined,
              color: Colors.white,
            ),
          ),
        ],
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
            AppLocalizations.of(context)?.statistics ?? "",
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
            _navigateToYourPets(context);
          },
          tileTitle: "$addedPets ${AppLocalizations.of(context)?.addedPetsLC}",
          isTileEnabled: addedPetsEnabled,
          leadingIcon: const Icon(
            Icons.pets,
            color: Colors.white,
          ),
          trailingIcon: trailingIconAddedPets,
        ),
        SettingsListTile(
          onTap: () {
            _navigateToYourPets(context);
          },
          tileTitle:
              "$adoptedPets ${AppLocalizations.of(context)?.adoptedPetsLC}",
          isTileEnabled: adoptedPetsEnabled,
          leadingIcon: const Icon(
            Icons.pets_outlined,
            color: Colors.white,
          ),
          trailingIcon: trailingIconAdoptedPets,
        ),
        const SizedBox(
          height: 10,
        ),
        if (!widget.currentUser.admin) ...[
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
        ],
        if (!widget.currentUser.admin) ...[
          const SizedBox(
            height: 5,
          ),
        ],
        if (!widget.currentUser.admin) ...[
          SettingsListTile(
            onTap: () {
              _makeAdmin(context);
            },
            tileTitle: AppLocalizations.of(context)?.makeAdmin ?? "",
            isTileEnabled: true,
            leadingIcon: const Icon(
              Icons.settings,
              color: Colors.white,
            ),
            trailingIcon: trailingIconAction,
          ),
        ],
      ],
    );
  }
}
