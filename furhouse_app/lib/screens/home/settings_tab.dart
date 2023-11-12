import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:furhouse_app/common/constants/others.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:furhouse_app/main_display.dart';

import 'package:furhouse_app/common/constants/colors.dart';

import 'package:furhouse_app/common/functions/modal_popup.dart';

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

  void _onLanguageChange(BuildContext context) async {
    var languageCode = await languageOptionModalPopup(context);

    if (languageCode == "cancel" || languageCode == null) {
      return;
    }

    setState(() {
      currentLocale.setLocale = languageCode;
    });

    if (context.mounted) {
      _navigateToLanding(context);
    }
  }

  void _onThemeChange(BuildContext context) async {
    var theme = await themeOptionModalPopup(context);

    if (theme == "cancel" || theme == null) {
      return;
    }

    switch (theme) {
      case "dark":
        {
          setState(() {
            darkerBlueColor = const Color.fromARGB(255, 0, 0, 0);
            darkBlueColor = const Color.fromARGB(255, 33, 34, 34);
            lightBlueColor = const Color.fromARGB(255, 129, 133, 136);
            lighterBlueColor = const Color.fromARGB(255, 255, 255, 255);

            unselectedLabelColor = const Color.fromARGB(255, 176, 192, 207);
            darkUnselectedLabelColor = const Color.fromARGB(255, 81, 92, 102);
          });
        }
        break;

      case "purple":
        {
          setState(() {
            darkerBlueColor = const Color.fromARGB(255, 67, 6, 75);
            darkBlueColor = const Color.fromARGB(255, 92, 18, 102);
            lightBlueColor = const Color.fromARGB(255, 172, 78, 196);
            lighterBlueColor = const Color.fromARGB(255, 241, 189, 252);

            unselectedLabelColor = const Color.fromARGB(255, 172, 124, 184);
            darkUnselectedLabelColor = const Color.fromARGB(255, 149, 106, 158);
          });
        }
        break;

      default:
        {
          setState(() {
            darkerBlueColor = const Color.fromARGB(255, 6, 44, 75);
            darkBlueColor = const Color.fromARGB(255, 18, 64, 102);
            lightBlueColor = const Color.fromARGB(255, 78, 143, 196);
            lighterBlueColor = const Color.fromARGB(255, 189, 223, 252);

            unselectedLabelColor = const Color.fromARGB(255, 124, 155, 184);
            darkUnselectedLabelColor = const Color.fromARGB(255, 106, 133, 158);
          });
        }
        break;
    }

    if (context.mounted) {
      _navigateToLanding(context);
    }
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
          onTap: () {
            _onLanguageChange(context);
          },
          tileTitle: "Language",
          leadingIcon: const Icon(
            Icons.language_rounded,
            color: Colors.white,
          ),
          trailingIcon: trailingIcon,
        ),
        SettingsListTile(
          onTap: () {
            _onThemeChange(context);
          },
          tileTitle: "Theme",
          leadingIcon: const Icon(
            Icons.color_lens_outlined,
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
        SettingsListTile(
          onTap: () {
            _onLogout(context);
          },
          tileTitle: "Logout",
          leadingIcon: const Icon(
            Icons.logout_outlined,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
