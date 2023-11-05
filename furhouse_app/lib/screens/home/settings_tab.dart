import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:furhouse_app/main_display.dart';

import 'package:furhouse_app/common/constants/colors.dart';

import 'package:furhouse_app/common/widget_templates/settings_list_tile.dart';

import 'package:furhouse_app/services/authentication.dart';

class SettingsTab extends StatefulWidget {
  const SettingsTab({
    super.key,
  });

  @override
  State<SettingsTab> createState() {
    return _SettingsTabState();
  }
}

class _SettingsTabState extends State<SettingsTab> {
  bool switchTileValue = true;
  Widget switchTileIcon = const Icon(
    CupertinoIcons.bell_fill,
    color: Colors.white,
  );

  void _onSwitchTileChangeValue(bool newValue) {
    setState(() {
      switchTileValue = newValue;

      switchTileIcon = Icon(
        newValue ? CupertinoIcons.bell_fill : CupertinoIcons.bell_slash_fill,
        color: Colors.white,
      );
    });
  }

  void _onLogout(BuildContext context) {
    Authentication().logout();

    _navigateToLanding(context);
  }

  void _navigateToLanding(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MainDisplay(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var trailingIcon = const Icon(
      CupertinoIcons.chevron_forward,
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
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                lighterBlueColor,
                lightBlueColor,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.all(
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
            "Display",
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
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              15,
            ),
          ),
          child: SwitchListTile(
            activeColor: Colors.white,
            activeTrackColor: lightBlueColor,
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: darkUnselectedLabelColor,
            tileColor: darkBlueColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                15,
              ),
            ),
            value: switchTileValue,
            onChanged: _onSwitchTileChangeValue,
            secondary: switchTileIcon,
            title: Text(
              "Notifications",
              style: GoogleFonts.roboto(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SettingsListTile(
          onTap: () {},
          tileTitle: "Language",
          leadingIcon: const Icon(
            Icons.language_rounded,
            color: Colors.white,
          ),
          trailingIcon: trailingIcon,
        ),
        SettingsListTile(
          onTap: () {},
          tileTitle: "Theme",
          leadingIcon: const Icon(
            Icons.color_lens_outlined,
            color: Colors.white,
          ),
          trailingIcon: trailingIcon,
        ),
        const SizedBox(
          height: 30,
        ),
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                lighterBlueColor,
                lightBlueColor,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          padding: const EdgeInsets.only(
            top: 5,
            bottom: 5,
            left: 10,
          ),
          child: Text(
            "General",
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
          tileTitle: "Account",
          leadingIcon: const Icon(
            Icons.settings,
            color: Colors.white,
          ),
          trailingIcon: trailingIcon,
        ),
        SettingsListTile(
          onTap: () {},
          tileTitle: "Adopted pets",
          leadingIcon: const Icon(
            Icons.pets_outlined,
            color: Colors.white,
          ),
          trailingIcon: trailingIcon,
        ),
        SettingsListTile(
          onTap: () {},
          tileTitle: "Admin",
          leadingIcon: const Icon(
            Icons.admin_panel_settings_outlined,
            color: Colors.white,
          ),
          trailingIcon: trailingIcon,
        ),
      ],
    );
    /*Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            onPressed: () {
              _onLogout(context);
            },
            child: const Text(
              "Logout",
            ),
          )
        ],
      ),
    );*/
  }
}
